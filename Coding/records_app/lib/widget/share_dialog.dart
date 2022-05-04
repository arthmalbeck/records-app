import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

Widget shareDialog(context, title, message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () async {
                // get file from local store
                final String dir =
                    (await getApplicationDocumentsDirectory()).path;
                final String path = '$dir/DiagramRecognized.xmi';

                ShareExtend.share(path, "file");
              },
            )
          ],
        );
      });
}
