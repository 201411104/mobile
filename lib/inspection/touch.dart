import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/inspection/sounds.dart';
import 'package:mobile/ready/sensorReady.dart';
import 'package:mobile/ready/soundsReady.dart';
import 'package:provider/provider.dart';

class TouchCheck {
  bool check;
  TouchCheck(){
    check = false;
  }
  void touchCheck(){
    check = true;
  }
}

class TouchTest extends StatefulWidget {
  @override
  TouchTestState createState() => TouchTestState();
}

class TouchTestState extends State<TouchTest> {
  final WIDTH = 2;
  final HEIGHT = 3;
  String startTest = 'start_test';
  List<TouchCheck> listTC = [
    new TouchCheck(),
    new TouchCheck(),
    new TouchCheck(),
    new TouchCheck(),
    new TouchCheck(),
    new TouchCheck(),
  ];
//  new List<TouchCheck>(6);

//  TouchCheck tc = new TouchCheck();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    var checker = Provider.of<Checker>(context, listen: false);
    return  Scaffold(
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onPanStart: (details){
                setState(() {
                  whichPosition(details.localPosition);
                  if(checkAll(listTC)){
                    checker.checkTouch();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=>HeadsetTest()));
                  }
                });
              },
              onPanUpdate: (details){
                setState(() {
                  whichPosition(details.localPosition);
                  if(checkAll(listTC)) {
                    checker.checkTouch();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=>HeadsetTest()));
                  }
                });
              },
              child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        touchTest(listTC[0]),
                        touchTest(listTC[1]),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        touchTest(listTC[2]),
                        touchTest(listTC[3])
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        touchTest(listTC[4]),
                        touchTest(listTC[5])
                      ],
                    ),
                  ]
              ),
            ),
            Center(
              child: Text('다 터치 하셈ㅋ'),
            )
          ],
        )
      );

  }

  Widget touchTest(TouchCheck tc){
    return
      Container(
        height: MediaQuery.of(context).size.height/HEIGHT,
        width: MediaQuery.of(context).size.width/WIDTH,
        color: tc.check ? Colors.yellow : Colors.grey,
      );

//    );
  }
  bool checkAll(List<TouchCheck> ltc){
    bool checking = true;
    for(int i =0; i < ltc.length ; i++){
      checking &= ltc[i].check;
    }
    return checking;
  }
  void whichPosition(Offset offset){
    if(offset.dx < MediaQuery.of(context).size.width/WIDTH){
      if(offset.dy <  MediaQuery.of(context).size.height/HEIGHT){
        listTC[0].touchCheck();
      } else if (offset.dy >= MediaQuery.of(context).size.height/HEIGHT && offset.dy < 2*MediaQuery.of(context).size.height/HEIGHT ){
        listTC[2].touchCheck();
      } else {
        listTC[4].touchCheck();
      }
    } else {

      if(offset.dy <  MediaQuery.of(context).size.height/HEIGHT){
        listTC[1].touchCheck();
      } else if (offset.dy >= MediaQuery.of(context).size.height/HEIGHT && offset.dy < 2*MediaQuery.of(context).size.height/HEIGHT ){
        listTC[3].touchCheck();
      } else {
        listTC[5].touchCheck();
      }
    }
  }
}