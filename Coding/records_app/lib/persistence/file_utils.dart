import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    //print("PATH -> " + path);
    return File('$path/DiagramRecognized.xmi');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    //print("FILEE PATH -> " +file.path);
    return file.writeAsString(data);
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return e.toString();
    }
  }
}