import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/func/func.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/inspection/camera.dart';
import 'package:provider/provider.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/design.dart';
import 'package:sim_info/sim_info.dart';

class AutoInspection extends StatefulWidget {
  @override
  _AutoInspectionState createState() => _AutoInspectionState();
}

class _AutoInspectionState extends State<AutoInspection> {
  Check check;
  int checked = 0;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final LocalAuthentication auth = LocalAuthentication();
  CameraController controller1, controller2;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    super.initState();
    wifiChecker();
    bluetoothChecker();
    simChecker();

    biometricsChecker();
    cameraChecker();
    gpsChecker();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider
        .of<Checker>(context)
        .check;
    if (check != this.check) {
      this.check = check;
    }
    // Provider.of<Checker>(context);
  }

  wifiChecker() async{
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.wifi){
      setState((){
        Provider.of<Checker>(context, listen: false).checkWifi();
      });
    } 
    else{
      new Duration(seconds: 1);
      wifiChecker();
    }
    
  }

  bluetoothChecker() async{
    if(await flutterBlue.isOn && await flutterBlue.isAvailable){
      setState(() {
        Provider.of<Checker>(context, listen: false).checkBluetooth();
      });
    }
    else{
      new Duration(seconds: 1);
      bluetoothChecker();
    }
  }

  simChecker() async{
    try{
      if(
      await SimInfo.getAllowsVOIP != null &&
          await SimInfo.getCarrierName != null &&
          await SimInfo.getIsoCountryCode != null &&
          await SimInfo.getMobileCountryCode != null &&
          await SimInfo.getMobileNetworkCode != null){
        setState(() {
          Provider.of<Checker>(context, listen: false).checkSim();
        });
      }
      else{
        new Duration(seconds: 1);
        simChecker();
      }
    }on Exception catch(e){};

  }



  biometricsChecker() async{
    List<BiometricType> availableBiometrics;
    availableBiometrics = await auth.getAvailableBiometrics();
    if(availableBiometrics != null){
      setState(() {
        Provider.of<Checker>(context, listen: false).checkBiometric();
      });
    }
    else{
      new Duration(seconds: 1);
      biometricsChecker();
    }
  }

  cameraChecker() async{
    cameras = await availableCameras();
    try{
      controller1 = new CameraController(cameras[0], ResolutionPreset.medium);
      controller2 = new CameraController(cameras[1], ResolutionPreset.medium);
      if(controller1 != null && controller2 != null){
        Provider.of<Checker>(context, listen: false).checkFrontCamera();
        Provider.of<Checker>(context, listen: false).checkBackCamera();
      }
      else{
        new Duration(seconds: 1);
        cameraChecker();
      }
    }on Exception catch(e) { }

  }

  gpsChecker() async{
    if(await geolocator.getCurrentPosition()!=null){
      setState(() {
        Provider.of<Checker>(context, listen: false).checkGeolocation();
      });
    }
    else{
      new Duration(seconds: 1);
      gpsChecker();
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fiveAppbar(
            Translations.of(context).trans("Inspection_results")),
        body: Container(
            child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: Text('자동 검사',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Scrollbar(
                      child: auto(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: Text('수동 검사',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Scrollbar(
                      child: manual(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: qrGenerator('https://naver.com?' + check.toString()),
                  )
                ]
            )
        )
    );
  }
  Widget auto(){
    return ListView(
      children: <Widget>[
        isCompleteTest(context, 'wifi', check.wifi),
        isCompleteTest(context, "bluetooth", check.bluetooth),
        isCompleteTest(context, "sim_card", check.sim),
        isCompleteTest(context, "accelero_sensor", check.accelerometer),
        isCompleteTest(context, "gyro_sensor", check.gyroscope),
        isCompleteTest(context, "compass", check.compass),
        isCompleteTest(context, "proximity_sensor", check.proximity),
        isCompleteTest(context, "ambient_light_sensor", check.ambientLight),
        isCompleteTest(context, "biometrics", check.biometric),
        isCompleteTest(context, "front_camera", check.frontCamera),
        isCompleteTest(context, "back_camera", check.backCamera),
        isCompleteTest(context, "geolocation", check.geolocation),
      ],
    );
  }

  Widget manual(){
    return ListView(
      children: <Widget>[
        isCompleteTest(context, "home_button", check.homeButton),
        isCompleteTest(context, "lock_button", check.lockButton),
        isCompleteTest(context, "volume_button", check.volumeUp && check.volumeDown),
        isCompleteTest(context, "headset_on_off", check.headsetOn && check.headsetOff),
        isCompleteTest(context, "touch", check.touch),
      ],
    );
  }
}