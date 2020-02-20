import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hardware_buttons/hardware_buttons.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/inspection/touch.dart';
import 'package:provider/provider.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/func.dart';


class HomeButtonTest extends StatefulWidget{
  HomeButtonTestState createState() => HomeButtonTestState();
}
class HomeButtonTestState extends State<HomeButtonTest>{

  bool isCheck = false;
  String buttons = "start_test";
  Check check;
  var next = MaterialPageRoute(builder: (context)=>LockButtonTest());

  StreamSubscription<HomeButtonEvent> homeStateSubscription;

  @override
  void initState(){
    super.initState();
    homeStateSubscription = homeButtonEvents.listen((HomeButtonEvent event){
     setState(() => updateHomeState());
     Navigator.of(context).popUntil((route) => route.isFirst);
     Navigator.pushReplacement(
         context,
         next);
    });
  }

  void updateHomeState(){
    isCheck =  true;
    Provider.of<Checker>(context, listen: false).checkHomeButton();
  }



  @override
  void dispose(){
    super.dispose();
    homeStateSubscription.cancel();

  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("home_button"),),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              turnColorIcon(isCheck, FontAwesomeIcons.home),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: skipButton(isCheck, context, next)
                  )
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        )
    );
  }
}


class LockButtonTest extends StatefulWidget{
  LockButtonTestState createState() => LockButtonTestState();
}
class LockButtonTestState extends State<LockButtonTest>{

  bool isCheck = false;
  String buttons = "start_test";
  Check check;
  StreamSubscription<LockButtonEvent> lockStateSubscription;
  var next = MaterialPageRoute(builder: (context)=>VolumeUpButtonTest());

  @override
  void initState() {

    super.initState();
    lockStateSubscription = lockButtonEvents.listen((LockButtonEvent event){
      setState(() => updateLockButton());
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          next);
    });
  }

  void updateLockButton(){
    isCheck = true;
    Provider.of<Checker>(context, listen: false).checkLockButton();
  }

  @override
  void dispose(){
    super.dispose();
    lockStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("lock_button"),),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              turnColorIcon(isCheck, FontAwesomeIcons.lock),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: skipButton(isCheck, context, next)
                  )
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        )
    );
  }
}



class VolumeUpButtonTest extends StatefulWidget{
  VolumeUpButtonTestState createState() => VolumeUpButtonTestState();
}
class VolumeUpButtonTestState extends State<VolumeUpButtonTest>{

  bool isCheck = false;
  Check check;
  String buttons = "start_test";
  StreamSubscription<VolumeButtonEvent> volumeStateSubscription;
  var next = MaterialPageRoute(builder: (context)=>VolumeDownButtonTest());

  @override
  void initState() {
    super.initState();
    volumeStateSubscription = volumeButtonEvents.listen((VolumeButtonEvent event){
      if (event == VolumeButtonEvent.VOLUME_UP) {
        updateUpStatus();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            next);
      }
    });
  }


  void updateUpStatus(){
    setState((){
      isCheck = true;
      Provider.of<Checker>(context ,listen: false).checkVolumeUp();
    });
  }

  @override
  void dispose(){
    super.dispose();
    volumeStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("volume_button"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            turnColorIcon(isCheck, FontAwesomeIcons.volumeUp),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: skipButton(isCheck, context, next)
                )
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}


class VolumeDownButtonTest extends StatefulWidget{
  VolumeDownButtonTestState createState() => VolumeDownButtonTestState();
}
class VolumeDownButtonTestState extends State<VolumeDownButtonTest>{

  bool isCheck = false;
  Check check;
  String buttons = "start_test";
  StreamSubscription<VolumeButtonEvent> volumeStateSubscription;
  var next = MaterialPageRoute(builder: (context)=>TouchTest());

  @override
  void initState() {
    super.initState();
    volumeStateSubscription = volumeButtonEvents.listen((VolumeButtonEvent event){
      if (event == VolumeButtonEvent.VOLUME_DOWN) {
        updateDownStatus();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            next);
      }
    });
  }


  void updateDownStatus(){
    setState((){
      isCheck= true;
      Provider.of<Checker>(context, listen: false).checkVolumeDown();
    });
  }

  @override
  void dispose(){
    super.dispose();
    volumeStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("volume_button"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            turnColorIcon(isCheck, FontAwesomeIcons.volumeDown),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: skipButton(isCheck, context, next)
                )
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}