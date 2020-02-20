import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/biometrics.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/ready/soundsReady.dart';

class BiometricsQueue extends StatefulWidget{
  BiometricsQueueState createState() => BiometricsQueueState();
}
class BiometricsQueueState extends State<BiometricsQueue>{

  bool isCheck = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("fingerprint"),),
        body: Container(
          margin: EdgeInsets.all(MYPADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              turnColorIcon(isCheck, FontAwesomeIcons.fingerprint),
              readyButtons(context,
              MaterialPageRoute(builder: (context)=> HeadsetQueue()),
              MaterialPageRoute(builder: (context)=> BiometricsTest())
            )
            ]
          )
      ),
    );
  }
}