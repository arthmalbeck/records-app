import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'constants.dart';

Future<String> processImage(Uint8List bytes, String rotation) async{
  const Base64Codec base64 = Base64Codec();
  var encoded = base64.encode(bytes);

  try {
    FormData formData = FormData.fromMap({
      "image": encoded,
      "rotation": rotation,
    });

    Dio dio = new Dio();
    Response response = await dio.post("http://$serverIP:$serverPort/$serverMapping/process-image", data: formData, options: Options(
        sendTimeout:100000000,
        receiveTimeout:100000000,
        ));

    return response.data;

  } on DioError catch (error) {
    print(error);
    print(error.response);
  }
}

Future<Uint8List> detect(Uint8List bytes, String rotation) async{
  const Base64Codec base64 = Base64Codec();
  var encoded = base64.encode(bytes);

  try {
    FormData formData = FormData.fromMap({
      "image": encoded,
      "rotation": rotation,
    });

    Dio dio = new Dio();
    Response response = await dio.post("http://$serverIP:$serverPort/$serverMapping/detect", data: formData);

    Uint8List teste = base64.decode(response.toString());

    return teste;

  } on DioError catch (error) {
    print(error);
    print(error.response);
  }
}