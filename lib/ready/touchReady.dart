import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/inspection/touch.dart';
import 'package:mobile/ready/sensorReady.dart';

class TouchQueue extends StatefulWidget {
  @override
  TouchQueueState createState() => TouchQueueState();
}

class TouchQueueState extends State<TouchQueue> {
 
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans('touch'),),
        body: Container(
          margin: EdgeInsets.all(MYPADDING),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              turnColorIcon(isCheck, Icons.touch_app),

              readyButtons(context,
                MaterialPageRoute(builder: (context)=> SensorQueue()),
                MaterialPageRoute(builder: (context)=> TouchTest())
              )
            ]
          )
        )
      ), 
    );
  }
}