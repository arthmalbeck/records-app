import 'package:flutter/material.dart';
import 'package:records_app/widget/footnote.dart';

/**
 * Created by Arthur Malmann Becker on 10/12/2019.
 */
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RecorDS"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin:  EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              width: 60.0,
              child: Image.asset('assets/labise_white.png', fit: BoxFit.fill,)
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(text: "LabISE was created in 2019 by software engineering researcher from "),
                      TextSpan(text: "Federal University of Pampa (Unipampa). ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "The research group is placed on "),
                      TextSpan(text: "Alegrete Campus ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "of Unipampa and it is registered in "),
                      TextSpan(text: "Brasilian Research Groups Directory, ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "which is maintained by "),
                      TextSpan(text: "National Council for Scientific and Technological Development (CNPq). ", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                )
            ),
          )
        ],
      ),
      bottomNavigationBar: FootNote(),
    );
  }
}
