import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/inspection/touch.dart';
import 'package:mobile/ready/communicationsReady.dart';
import 'package:mobile/ready/touchReady.dart';
import 'package:provider/provider.dart';
import 'package:sim_info/sim_info.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/main.dart';

class WifiTest extends StatefulWidget{

  WifiTestState createState() => WifiTestState();
}
class WifiTestState extends State<WifiTest>{

  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;

  bool isStart = false;
  bool isCheck = false;
  StreamSubscription st;

  String wifiState = 'wifi';
  ConnectivityResult result ;

  @override
  void initState(){
    super.initState();
    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> BluetoothQueue()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
        updateStatus();
      });
      return isCheck;
    });  
  }

  updateStatus() async{
    result = await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.wifi){
      setState((){
        wifiState = 'wifi_y';
        isCheck = true;
        Provider.of<Checker>(context, listen: false).checkWifi();
      });
    }
  }

  @override
  void dispose(){
    super.dispose();
    st.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("wifi"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, Icons.wifi),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: timerStyle(_current, _size, _color)
              )
            ),
          ]
        )
      )
    );
  }
}

class BluetoothTest extends StatefulWidget{

  BluetoothTestState createState() => BluetoothTestState();
}
class BluetoothTestState extends State<BluetoothTest>{

  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;

  FlutterBlue flutterBlue = FlutterBlue.instance;

  String bluetoothState = 'bluetooth';
  StreamSubscription st;
  bool isStart = false;
  bool isCheck = false;

  @override
  void initState(){
    super.initState();
    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> SimQueue()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
        updateStatus();
      });
      return isCheck;
    });
  }

  updateStatus() async{
    if(await flutterBlue.isOn && await flutterBlue.isAvailable){
      setState((){
        bluetoothState = "bluetooth_y";
        isCheck = true;
        Provider.of<Checker>(context, listen: false).checkBluetooth();
      });
    }
    else if(await flutterBlue.isOn && !await flutterBlue.isAvailable)
      setState(() => bluetoothState = "bluetooth_n");
    else
      setState(() => bluetoothState = "bluetooth_e");
  }

  @override
  void dispose(){
    super.dispose();
    st.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("bluetooth"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, Icons.bluetooth),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: timerStyle(_current, _size, _color)
              )
            ),
          ]
        )
      )
    );
  }
// void checked(){
//   Text(Translations.of(context).trans(bluetoothStatus));
// }
}

class SimTest extends StatefulWidget{
  SimTestState createState() => SimTestState();
}
class SimTestState extends State<SimTest>{
  String _allowsVOIP;
  String _carrierName;
  String _isoCountryCode;
  String _mobileCountryCode;
  String _mobileNetworkCode;

  String simState = 'sim_card';
  
  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;
  StreamSubscription st;
  bool isCheck = false;
  bool isStart = false;

  @override
  void initState(){
    super.initState();
updateStatus();
  }

  updateStatus() async{
    String allowsVOIP = await SimInfo.getAllowsVOIP;
    String carrierName = await SimInfo.getCarrierName;
    String isoCountryCode = await SimInfo.getIsoCountryCode;
    String mobileCountryCode = await SimInfo.getMobileCountryCode;
    String mobileNetworkCode = await SimInfo.getMobileNetworkCode;

    _allowsVOIP = allowsVOIP;
    _carrierName = carrierName;
    _isoCountryCode = isoCountryCode;
    _mobileCountryCode = mobileCountryCode;
    _mobileNetworkCode = mobileNetworkCode;

    if(await SimInfo.getAllowsVOIP != null && await SimInfo.getCarrierName != null
        && await SimInfo.getIsoCountryCode != null && await SimInfo.getMobileCountryCode != null
        && await SimInfo.getMobileNetworkCode != null){
      setState((){
        simState = 'sim_n';
        isCheck = true;
        Provider.of<Checker>(context, listen: false).checkSim();
      });
    }
  }

  @override
  void dispose(){
    super.dispose();
    st.cancel();
  }

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
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: timerStyle(_current, _size, _color)
              )
            ),
          ],
        ),
      ),
    );
  }
}