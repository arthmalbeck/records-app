import 'package:flutter/material.dart';

Widget loading({String title, Color color: Colors.white}) {
  return Center(
    child: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color)),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    ),
  );
}
