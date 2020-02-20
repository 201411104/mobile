
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/sensors.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/ready/biometricsReady.dart';

import '../func/func.dart';

class SensorQueue extends StatefulWidget{
  _SensorQueueState createState() => _SensorQueueState();
}
class _SensorQueueState extends State<SensorQueue> {

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("sensor"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.broadcastTower),

            readyButtons(context,
              MaterialPageRoute(builder: (context)=> ProximityQueue()),
              MaterialPageRoute(builder: (context)=> SensorTest())
            )
          ]
        )
      )
    );
  }
}

class ProximityQueue extends StatefulWidget{
  _ProximityQueueState createState() => _ProximityQueueState();
}
class _ProximityQueueState extends State<ProximityQueue> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: fiveAppbar(Translations.of(context).trans("proximity_sensor"),),
       body: Container(
          margin: EdgeInsets.all(MYPADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              turnColorIcon(isCheck, FontAwesomeIcons.satelliteDish),

              readyButtons(context,
                MaterialPageRoute(builder: (context)=> AmbientLightQueue()),
                MaterialPageRoute(builder: (context)=> ProximityTest())
              )
            ]
          )
        )
    );
  }
}

class AmbientLightQueue extends StatefulWidget{
  _AmbientLightQueueState createState() => _AmbientLightQueueState();
}
class _AmbientLightQueueState extends State<AmbientLightQueue> {
  bool isCheck =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("ambient_light_sensor"),),
      body: Container(
          margin: EdgeInsets.all(MYPADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              turnColorIcon(isCheck, FontAwesomeIcons.lightbulb),

              readyButtons(context,
                MaterialPageRoute(builder: (context)=> BiometricsQueue()),
                MaterialPageRoute(builder: (context)=> AmbientLightTest())
              )
            ]
          )
        )
    );
  }
}