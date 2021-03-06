import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:records_app/camera_handler.dart';
import 'package:records_app/yuv_transform_screen.dart';

import 'view/home_screen.dart';

Future<void> main() async {
  // Required for observing the lifecycle state from the widgets layer.
  WidgetsFlutterBinding.ensureInitialized();
  //Request permission for camera
  PermissionStatus status = await Permission.camera.status;
  while (!status.isGranted) status = await Permission.camera.request();
  // Fetch all available cameras.
  cameras = await availableCameras();
  // Keep rotation at portrait mode.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecorDS',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor:Color.fromARGB(245, 31, 31, 31),
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}
