import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/qrcode_UI.dart';

class SpeakerTest extends StatefulWidget {
  @override
  _SpeakerTestState createState() => _SpeakerTestState();
}
class _SpeakerTestState extends State<SpeakerTest> {
  var next = MaterialPageRoute(builder: (context)=> QRCode());

  static AudioCache player = AudioCache();

  String path;
  int isChecked = 0;
  int isStarted = 0;
  bool isCheck = false;
  String startTest = 'start_test';

  @override
  void initState(){
    super.initState();
//    updateStatus();

  }

  @override
  void dispose(){
    super.dispose();
  }

  Future<void> updateStatus() async{
    setState((){
      isStarted++;
      isStarted==1?setState(()=> path='200hz'):
      isStarted==2?setState(()=> path='500hz'):
      isStarted==3?setState(()=> path='1000hz'):
      isStarted==4?setState(()=> path='5000hz'):
      isStarted==5?setState(()=> path='10000hz'):
      isStarted==6?setState(()=> path='15000hz'):
      isStarted>=7?setState(()=> isCheck = true): DoNothingAction();
      player.play('sample_sound/$path.wav');
    });
    checkSound();
  }

  void checkSound() async{
    await Future.delayed(new Duration(seconds: 2));
    setState(() => isChecked++);
    if(isStarted == isChecked){
      player.clearCache();
      updateStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("speaker"),),
      body: Container(
        child: Column(
          children: <Widget>[
            checkBox(isStarted == 1, isChecked>=1, context, '200hz'),
            checkBox(isStarted == 2, isChecked>=2, context, '500hz'),
            checkBox(isStarted == 3, isChecked>=3, context, '1000hz'),
            checkBox(isStarted == 4, isChecked>=4, context, '5000hz'),
            checkBox(isStarted == 5, isChecked>=5, context, '10000hz'),
            checkBox(isStarted == 6, isChecked>=6, context, '15000hz'),
            Expanded(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text("")
              ),
            )
          ],
        ),
      ),
    );
  }
}