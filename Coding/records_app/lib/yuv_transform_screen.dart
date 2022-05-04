import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:records_app/camera_handler.dart';
import 'package:records_app/persistence/file_utils.dart';
import 'package:records_app/service/image_process/image_result_processor_service.dart';
import 'package:records_app/widget/share_dialog.dart';
import 'package:records_app/widget/loading_dialog.dart';
import 'package:records_app/service/image_process/upload_photo.dart';
import 'view/camera_screen.dart';

class YuvTransformScreen extends StatefulWidget {
  @override
  _YuvTransformScreenState createState() => _YuvTransformScreenState();
}

class _YuvTransformScreenState extends State<YuvTransformScreen>
    with CameraHandler, WidgetsBindingObserver {
  List<StreamSubscription> _subscription = List();
  ImageResultProcessorService _imageResultProcessorService;
  bool _isProcessing = false;

  File _xmlFile;
  Uint8List imgWS;
  Uint8List frame;
  Image imgPreview;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    // Registers the page to observer for life cycle managing.
    _imageResultProcessorService = ImageResultProcessorService();
    WidgetsBinding.instance.addObserver(this);
    _subscription.add(_imageResultProcessorService.queue.listen((event) {
      _isProcessing = false;
    }));
    onNewCameraSelected(cameras[cameraType]);
  }

  @override
  void dispose() {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance.removeObserver(this);
    // Dispose all streams!
    _subscription.forEach((element) {
      element.cancel();
    });
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller?.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        print("Camera error: ${controller.value.errorDescription}");
      }
    });

    try {
      await controller.initialize();

      await controller.lockCaptureOrientation(DeviceOrientation.landscapeLeft);

      await controller
          .startImageStream((CameraImage image) => _processCameraImage(image));
    } on CameraException catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _processCameraImage(CameraImage image) async {
    if (_isProcessing)
      return; //Do not detect another image until you finish the previous.
    _isProcessing = true;
    // print("Sent a new image and sleeping for: $DELAY_TIME");
    await Future.delayed(Duration(milliseconds: DELAY_TIME),
      () async => {
        frame = await _imageResultProcessorService.addRawImage(image),
        imgWS = await detect(frame, "-90"),
        imgPreview = Image.memory(imgWS, gaplessPlayback: true),
        if (this.mounted) {
          setState(() {})
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("RecorDS"),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async{
                    if (frame != null) {

                      // final dir = await getExternalStorageDirectory();
                      // File(dir.path + "/frame.png").writeAsBytes(frame);

                      _isProcessing = true;
                      showLoadingDialog(context: context, text: 'Processing...');
                      _xmlFile = await FileUtils.saveToFile(await  processImage(frame, "-90"));
                      //SALVAR ARQUIVO
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if(_xmlFile != null){
                      shareDialog(context, "Diagram Already Recognized", "Your diagram is already recognized and is ready to be shared.");
                    }
                  },
                )
              ],
            ),
            // extendBodyBehindAppBar: true,
            body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        // fit: BoxFit.fitHeight,
                        child: imgPreview == null ? Container() : imgPreview,
                      )
                    ),
                  ]
                ),
            ),
        ),
    );
  }
}
