import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/Translations.dart';

import 'inspection/autoinspection.dart';
class Announce extends StatefulWidget {
  @override
  _AnnounceState createState() => _AnnounceState();
}

class _AnnounceState extends State<Announce> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans('device_info'),),
        body: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(Translations.of(context).trans('announcement')),
                Container(),
              ],
            ),
            Column(
              children: <Widget>[
                Text(Translations.of(context).trans('notice')),
                Container()
              ],
            ),
            RaisedButton(
              child: Text(Translations.of(context).trans('confirm')),
              onPressed: (){
//                Navigator.of(context).popUntil((route) => route.isFirst);
//                Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(builder: (context)=> Announce()));
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> AutoInspection()));
              },
            )
          ],
        )
    );
  }
}