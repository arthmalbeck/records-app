import 'package:flutter/material.dart';


/**
 * Created by Arthur Malmann Becker on 11/12/2019.
 */
class FootNote extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        color: Theme.of(context).primaryColor,
        child: Text(
          "Developed by LabISE",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
