import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/biometrics.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/inspection/camera.dart';

import 'package:mobile/ready/backCameraReady.dart';

class FrontCameraQueue extends StatefulWidget {
  @override
  _FrontCameraQueueState createState() => _FrontCameraQueueState();
}

class _FrontCameraQueueState extends State<FrontCameraQueue> {

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("front_camera"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.camera),
            readyButtons(context,
                MaterialPageRoute(builder: (context)=> BackCameraQueue()),
                MaterialPageRoute(builder: (context)=> FrontCameraTest())
            )
          ],
        ),
      ),
    );
  }
}
