import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/biometrics.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/inspection/camera.dart';
import 'package:mobile/inspection/sensors.dart';

import 'package:mobile/program.dart';

class GeoLocationQueue extends StatefulWidget {
  @override
  _GeoLocationQueueState createState() => _GeoLocationQueueState();
}

class _GeoLocationQueueState extends State<GeoLocationQueue> {

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("geolocation"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.searchLocation),
            readyButtons(context,
                MaterialPageRoute(builder: (context)=> Program()),
                MaterialPageRoute(builder: (context)=> GeoLocationTest())
            )
          ],
        ),
      ),
    );
  }
}
