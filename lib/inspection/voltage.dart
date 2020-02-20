import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/design.dart';
import 'package:battery/battery.dart';

class BatteryTest extends StatefulWidget{

  BatteryTestState createState() => BatteryTestState();
}

class BatteryTestState extends State<BatteryTest>{
  Battery battery = Battery();
  BatteryState batteryState;
  StreamSubscription<BatteryState> batteryStateSubscription;

  bool isStart = false;
  bool isCheck = false; 

  String _batteryLevel = '';
  String _batteryStatus = '';
  String _chargingStatus = '';

  @override
  void initState() {
    super.initState();
    batteryStateSubscription = battery.onBatteryStateChanged.listen((BatteryState state){
      setState(()=> batteryState = state);
    });
  }

  @override
  void dispose(){
    super.dispose();
    batteryStateSubscription.cancel();
  }

  Future<void> updateStatus() async{
    final int batteryLevel = await battery.batteryLevel;
    setState(()=> _batteryLevel = '$batteryLevel');
    batteryState == BatteryState.full?
    _chargingStatus = 'full': batteryState == BatteryState.charging?
    _chargingStatus = 'charging' : batteryState == BatteryState.discharging?
    _chargingStatus = 'discharging' : _chargingStatus = 'error';
    
    setState(() => _batteryStatus = Translations.of(context).trans('$_chargingStatus'));

    isCheck=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("battery"),),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: isCheck
                      ? Icon(Icons.check_box)
                      : isStart
                      ? CircularProgressIndicator()
                      : Icon(Icons.check_box_outline_blank),
                    title: Text('${Translations.of(context).trans('battery_level')} : $_batteryLevel%',),
                  ),
                  ListTile(
                    leading: isCheck
                      ? Icon(Icons.check_box)
                      : isStart
                      ? CircularProgressIndicator()
                      : Icon(Icons.check_box_outline_blank),
                    title: 
                    Text('${Translations.of(context).trans('battery_status')} : $_batteryStatus',),
                  )
                ],
              ),
              flex: 4,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child : Text(Translations.of(context).trans('start_test'),),
                    onPressed: (){
                      updateStatus();
                      setState(()=> isStart = true);
                      },
                  ),
                  RaisedButton(
                    child : Text(Translations.of(context).trans('confirm'),),
                    onPressed: isCheck?(){
                      Navigator.pop(context);
                    }
                    :null,
                  )
                ],
              ),
            ),
          ],
        )
       ),
    );
  }
}

