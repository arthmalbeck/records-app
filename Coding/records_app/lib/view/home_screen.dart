import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:records_app/service/network/network_status_service.dart';
import 'package:records_app/widget/card_diagram.dart';
import 'package:records_app/widget/footnote.dart';
import 'package:connectivity/connectivity.dart';
import 'package:records_app/widget/network_aware.dart';

import 'drawer_screen.dart';

/**
 * Created by Arthur Malmann Becker on 10/12/2019.
 */
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RecorDS"),
        centerTitle: true,
      ),
      drawer: DrawerScreen(),
      body: StreamProvider<NetworkStatus>(
        create: (context) =>
        NetworkStatusService().networkStatusController.stream,
        child: NetworkAwareWidget(
          onlineChild: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "What you want to recognize?",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CardDiagram(),
              ),
            ],
          ),
          offlineChild: Container(
            child: Center(
              child: Text(
                "No internet connection!",
                style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FootNote(),
    );
  }
}
