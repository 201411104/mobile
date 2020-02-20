import 'dart:async';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hardware_buttons/hardware_buttons.dart';
import 'package:mobile/func/providers.dart';
import 'package:provider/provider.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/main.dart';


class HomeButtonQueue extends StatefulWidget {
  @override
  _HomeButtonQueueState createState() => _HomeButtonQueueState();
}

class _HomeButtonQueueState extends State<HomeButtonQueue> {

  bool isStart = false;
  bool isCheck = false;
  String buttons = "start_test";
  Check check;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("home_button"),),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(MYPADDING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(Translations.of(context).trans('skip'),),
                  onPressed: ()=> Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> LockButtonTest())),
                ),
                RaisedButton(
                  child: Text(Translations.of(context).trans('start_test'),),
                  onPressed: ()=> Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> HomeButtonTest())),
                ),
              ],
            ),
          ),
          Container()
        ],
      )

    );
  }
}

class HomeButtonTest extends StatefulWidget{
  HomeButtonTestState createState() => HomeButtonTestState();
}
class HomeButtonTestState extends State<HomeButtonTest>{

  int _current = 10;
  bool isStart = false;
  bool isCheck = false;
  String buttons = "start_test";
  Check check;
  double _size = 40.0;
  Color _color = Colors.white;

  StreamSubscription<HomeButtonEvent> homeStateSubscription;

  @override
  void initState(){
    super.initState();
    isStart=true;
    homeStateSubscription = homeButtonEvents.listen((HomeButtonEvent event){
      if(isStart) setState(() => updateHomeState());
    });

    startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> LockButtonTest()),(){
      setState(() {
        _current--;
        if(_current > 5) _color = Colors.red[(10-_current)*100];
        else _size = (9-_current)*10.0;
      });
      return isCheck;
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
    final checker = Provider.of<Checker>(context);

    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("home_button"),),
        body: Container(
          child: Column(
            children: <Widget>[
              checkBox(isStart, isCheck, context, 'home_button_title'),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: timerStyle(_current, _size, _color) 
                )
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    skipButton(isCheck, context, MaterialPageRoute(builder: (context)=> LockButtonTest())),
                    startAndConfirm(isStart, isCheck, buttons, context, MaterialPageRoute(builder: (context)=> LockButtonTest()), (){
                      setState(() {
                        buttons = 'confirm';
                        //isStart = true;
                      });
                    })
                  ],
                ),
                flex: 1,
              )
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
  bool isStart = false;
  String buttons = "start_test";
  Check check;
  StreamSubscription<LockButtonEvent> lockStateSubscription;

  @override
  void initState() {

    super.initState();
    lockStateSubscription = lockButtonEvents.listen((LockButtonEvent event){
      if (isStart) setState(() => updateLockButton());
    });
  }
  void updateLockButton(){
    isCheck = true;
    Provider.of<Checker>(context, listen: false).checkLockButton();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context, listen: false).check;
    if(check != this.check){
      this.check = check;
      isStart = check.lockButton;
      isCheck = check.lockButton;
    }
  }

  @override
  void dispose(){
    super.dispose();
    lockStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context){
    final checker = Provider.of<Checker>(context);
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("lock_button"),),
        body: Container(
          child: Column(
            children: <Widget>[
              checkBox(isStart, isCheck, context, 'lock_button_title'),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    skipButton(isCheck, context, MaterialPageRoute(builder: (context)=> VolumeUpButtonTest())),
                    startAndConfirm(isStart, isCheck, buttons, context, MaterialPageRoute(builder: (context)=> VolumeUpButtonTest()), (){
                      setState(() {
                        buttons = 'confirm';
                        isStart = true;
                      });
                    }),
                  ],
                ),
                flex: 1,
              )
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
  bool isStart = false;
  Check check;
  String buttons = "start_test";
  String err = 'err';

//  VolumeButtonEvent volumeState;
  StreamSubscription<VolumeButtonEvent> volumeStateSubscription;

  @override
  void initState() {
    super.initState();
    volumeStateSubscription = volumeButtonEvents.listen((VolumeButtonEvent event){
      if (isStart) {
        if (event == VolumeButtonEvent.VOLUME_UP) updateUpStatus();
//        if (event == VolumeButtonEvent.VOLUME_DOWN) updateDownStatus();
      }
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context).check;
    if(check != this.check){
      this.check = check;
      isCheck = check.volumeUp;
      if(isCheck)
        isStart = true;
    }
  }
  void updateUpStatus(){
    setState((){
      isCheck = true;
      Provider.of<Checker>(context ,listen: false).checkVolumeUp();
    });
  }
//  void updateDownStatus(){
//    setState((){
//      isCheckedDown = true;
//      Provider.of<Checker>(context, listen: false).checkVolumeDown();
//    });
//  }

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
          children: <Widget>[
            checkBox(isStart, isCheck, context, "up"),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  skipButton(isCheck, context, MaterialPageRoute(builder: (context)=> VolumeDownButtonTest())),
                  startAndConfirm(isStart, isCheck, buttons, context, MaterialPageRoute(builder: (context)=> VolumeDownButtonTest()), (){
                    setState(() {
                      buttons = 'confirm';
                      isStart = true;
                    });
                  })
                ],
              ),
              flex: 1,
            )
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
  bool isStart = false;
  Check check;
  String buttons = "start_test";
  String err = 'err';

//  VolumeButtonEvent volumeState;
  StreamSubscription<VolumeButtonEvent> volumeStateSubscription;

  @override
  void initState() {
    super.initState();
    volumeStateSubscription = volumeButtonEvents.listen((VolumeButtonEvent event){
      if (isStart) {
        if (event == VolumeButtonEvent.VOLUME_DOWN) updateDownStatus();
      }
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context).check;
    if(check != this.check){
      this.check = check;
      isCheck = check.volumeDown;
      if(isCheck)
        isStart = true;
    }
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
          children: <Widget>[
            checkBox(isStart, isCheck, context, "down"),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  skipButton(isCheck, context, MaterialPageRoute(builder: (context)=> MyHomePage(title: "pineapple",))),
                  startAndConfirm(isStart, isCheck, buttons, context, MaterialPageRoute(builder: (context)=> MyHomePage(title: "pineapple",)), (){
                    setState(() {
                      buttons = 'confirm';
                      isStart = true;
                    });
                  })
                ],
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}