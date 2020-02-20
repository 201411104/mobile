import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/ready/speakerReady.dart';
import 'package:provider/provider.dart';
import '../func/Translations.dart';


class HeadsetTest extends StatefulWidget{
  HeadsetTestState createState() => HeadsetTestState();
}

class HeadsetTestState extends State<HeadsetTest>{
  bool isCheckedOn = false;
  bool isCheckedOff = false;
  String startTest = 'start_test';
  @override
  void initState(){
    super.initState();
    test();
  }

  @override
  void dispose(){
    super.dispose();
  }

  static const MethodChannel methodChannel =
  MethodChannel('pineapple.flutter.io/headset');
  bool _headsetInfo = false;

  Future<void> plugHeadset() async {
    bool headsetInfo;
    try{
      while (!(headsetInfo = await methodChannel.invokeMethod('headsetInfo'))){}

      setState(() {
        _headsetInfo = headsetInfo;
        Provider.of<Checker>(context, listen: false).checkHeadsetOn();
        isCheckedOn = true;
      });
    }on MissingPluginException catch(e){}

  }
  Future<void> unPlugHeadset() async {
    bool headsetInfo;
    try{
      while (headsetInfo = await methodChannel.invokeMethod('headsetInfo')){}

      setState(() {
        _headsetInfo = headsetInfo;
        Provider.of<Checker>(context, listen: false).checkHeadsetOff();
        isCheckedOff = true;
      });
    }on MissingPluginException catch(e){}

  }
  Future<void> moveScreen() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SpeakerQueue()));
  }
  Future<void> test() async {

    await plugHeadset();
    await unPlugHeadset();
    await moveScreen();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("headset_on_off"),),
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            turnColorIcon(isCheckedOn && isCheckedOff, Icons.headset),
            Text(_headsetInfo ?? false ? Translations.of(context).trans("unplug_a_headphone") : Translations.of(context).trans("put_a_headphone")),
            Spacer(
              flex: 1,
            )
          ],
        ),
      )
    );
  }
}