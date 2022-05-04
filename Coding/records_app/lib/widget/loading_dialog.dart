import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoadingDialog({@required BuildContext context, String text}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.black54,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
                (text != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                text,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      );
    },
  );
}
