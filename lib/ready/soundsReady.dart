import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/inspection/sounds.dart';
import 'package:mobile/ready/speakerReady.dart';

class HeadsetQueue extends StatefulWidget {
  @override
  _HeadsetQueueState createState() => _HeadsetQueueState();
}

class _HeadsetQueueState extends State<HeadsetQueue> {

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("headset_on_off")),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.headset),
            Column(
              children: <Widget>[
                Text("'검사시작' 버튼을 누른 후, 검사 화면으로 넘어가면",textAlign: TextAlign.center,),
                Text("이어폰 잭을 꽂았다가 빼주세요.",textAlign: TextAlign.center,)
              ],
            ),
            readyButtons(context,
                MaterialPageRoute(builder: (context)=> SpeakerQueue()),
                MaterialPageRoute(builder: (context)=> HeadsetTest())
            )
          ],
        ),
      ),
    );
  }
}
