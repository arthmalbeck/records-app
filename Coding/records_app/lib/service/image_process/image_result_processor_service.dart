import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:exif/exif.dart';
import 'package:records_app/method_channelling/yuv_chanelling.dart';
import 'package:rxdart/subjects.dart';
import 'package:records_app/service/image_process/upload_photo.dart';
import 'package:image/image.dart' as img;

class ImageResultProcessorService  {
  YuvChannelling _yuvChannelling = YuvChannelling();
  /// We need to notify the page that we have finished the process of the image.
  /// The subject could possibly sink the result [Uint8List] if needed.
  PublishSubject<Uint8List> _queue = PublishSubject();
  /// Observers that needs the result image should subscribe to this stream.
  Stream<Uint8List> get queue => _queue.stream;

  Future<Uint8List> addRawImage(CameraImage cameraImage) async {
    // num sTime = DateTime.now().millisecondsSinceEpoch;
    Uint8List imgJpeg = await _yuvChannelling.yuv_transform(cameraImage);

    // Uint8List fixed = await fixExifRotation(imgJpeg);

    // print("Job took ${(DateTime.now().millisecondsSinceEpoch - sTime)/1000} seconds to complete.");
    _queue.sink.add(imgJpeg);

    return imgJpeg;
  }

  void dispose() {
    _queue.close();
  }

}

Future<Uint8List> fixExifRotation(Uint8List image) async {
  Uint8List imageBytes = image;

  final originalImage = img.decodeImage(imageBytes);

  final height = originalImage.height;
  final width = originalImage.width;

  // Let's check for the image size
  // This will be true also for upside-down photos but it's ok for me
  if (height >= width) {
    // I'm interested in portrait photos so
    // I'll just return here
    return image;
  }

  // We'll use the exif package to read exif data
  // This is map of several exif properties
  // Let's check 'Image Orientation'
  final exifData = await readExifFromBytes(imageBytes);

  img.Image fixedImage;

  print(exifData['Image Orientation']);

  if (height < width) {
    // rotate
    if (exifData['Image Orientation'].printable.contains('Horizontal')) {
      fixedImage = img.copyRotate(originalImage, 90);
    } else if (exifData['Image Orientation'].printable.contains('180')) {
      fixedImage = img.copyRotate(originalImage, -90);
    } else if (exifData['Image Orientation'].printable.contains('CCW')) {
      fixedImage = img.copyRotate(originalImage, 180);
    } else {
      fixedImage = img.copyRotate(originalImage, 0);
    }
  }

  // Here you can select whether you'd like to save it as png
  // or jpg with some compression
  // I choose jpg with 100% quality
  final fixedFile = img.encodeJpg(fixedImage);

  return fixedFile;
}