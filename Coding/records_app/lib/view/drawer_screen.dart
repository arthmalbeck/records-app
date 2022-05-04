import 'package:flutter/material.dart';

import 'about_screen.dart';
import 'home_screen.dart';

/**
 * Created by Arthur Malmann Becker on 10/12/2019.
 */
class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          //_buildDrawerBack(),
          ListView(
            children: <Widget>[
              Container(
                  margin:  EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  width: 60.0,
                  child: Image.asset('assets/labise_white.png', fit: BoxFit.fill,)
              ),
              Divider(),
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => App()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.home),
                      Text(" Home")
                    ],
                  )
              ),
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.error),
                      Text(" About")
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
