import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/communications.dart';
import 'package:mobile/ready/touchReady.dart';
import '../func/Translations.dart';
import '../func/func.dart';

class WifiQueue extends StatefulWidget{

  WifiQueueState createState() => WifiQueueState();
}
class WifiQueueState extends State<WifiQueue>{
  
  bool isCheck = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: fiveAppbar(Translations.of(context).trans("wifi"),),
       body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.wifi),
           
            readyButtons(context,
                MaterialPageRoute(builder: (context)=> BluetoothQueue()),
                MaterialPageRoute(builder: (context)=> WifiTest())
            )
          ]
        )
      )
    );
  }
}

class BluetoothQueue extends StatefulWidget{

  BluetoothQueueState createState() => BluetoothQueueState();
}
class BluetoothQueueState extends State<BluetoothQueue>{

  bool isCheck = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("bluetooth"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.bluetooth),

            readyButtons(context,
                MaterialPageRoute(builder: (context)=> SimQueue()),
                MaterialPageRoute(builder: (context)=> BluetoothTest())
            )
          ]
        )
      )
    );
  }
}

class SimQueue extends StatefulWidget{
  SimQueueState createState() => SimQueueState();
}
class SimQueueState extends State<SimQueue>{
 
  bool isCheck = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("sim_card"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.simCard),

            readyButtons(context,
                MaterialPageRoute(builder: (context)=> TouchQueue()),
                MaterialPageRoute(builder: (context)=> SimTest())
            )
          ],
        ),
      ),
    );
  }
}