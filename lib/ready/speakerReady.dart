import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/inspection/camera.dart';
import 'package:mobile/inspection/speaker.dart';
import 'package:mobile/qrcode_UI.dart';
import 'package:mobile/ready/frontCameraReady.dart';

class SpeakerQueue extends StatefulWidget {
  @override
  _SpeakerQueueState createState() => _SpeakerQueueState();
}

class _SpeakerQueueState extends State<SpeakerQueue> {
  bool isStart = false;
  bool isCheck = false;
  String buttons = "start_test";
  var next = MaterialPageRoute(builder: (context)=> QRCode());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("speaker")),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.speakerDeck),
            readyButtons(context,
                next,
                MaterialPageRoute(builder: (context)=> SpeakerTest()))
          ],
        ),
      ),
    );
  }
}
