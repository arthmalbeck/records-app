import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:records_app/widget/modal_bottom_sheet.dart';

import '../yuv_transform_screen.dart';


/**
 * Created by Arthur Malmann Becker on 30/07/2020.
 */
class CardDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  YuvTransformScreen()));
        // ModalBottomSheet(context);
      },
      child: Center(
          child: ExpansionCard(
            borderRadius: 20,
            background:Image.asset(
              "assets/red-gradient.jpg",
              fit: BoxFit.cover,
            ),
            title: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  YuvTransformScreen()));
                // ModalBottomSheet(context);
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "UML",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Unified Modeling Language",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            children: <Widget>[
              Divider(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text("The UML is a general-purpose, developmental, modeling language in the field of software engineering that is intended to provide a standard way to visualize the design of a system.",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              )
            ],
          )
      ),
    );
  }
}

