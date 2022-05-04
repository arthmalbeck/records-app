import 'dart:io';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:records_app/persistence/file_utils.dart';
import 'package:records_app/service/image_process/upload_photo.dart';
import 'package:records_app/widget/loading_dialog.dart';


import '../yuv_transform_screen.dart';
import 'share_dialog.dart';

void ModalBottomSheet(BuildContext context) {
  File _xmlFile;

  showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
                child: Wrap(
                    children: <Widget>[
                      ListTile(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  YuvTransformScreen()));
                      },
                      title: Text('Capture Image'),
                      leading: Icon(Icons.camera_alt)
                    ),
                    ListTile(
                      onTap: () async {
                        PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
                        if (image != null) {
                          showLoadingDialog(context: context, text: 'Processing...');

                          Uint8List bytes = await image.readAsBytes();


                          _xmlFile = await FileUtils.saveToFile(await processImage(bytes, "-90"));
                          //SALVAR ARQUIVO
                        }
                        Navigator.pop(context);
                        if(_xmlFile != null){
                          shareDialog(context, "Diagram Already Recognized", "Your diagram is already recognized and is ready to be shared.");
                        }
                      },
                      title: Text('Gallery Image'),
                      leading: Icon(Icons.cloud_upload),
                    ),
              ],
            ),
          ),
        ),
        );
      });
}