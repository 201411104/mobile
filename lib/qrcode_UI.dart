import 'package:flutter/material.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/Translations.dart';
import 'package:mobile/func/func.dart';
import 'package:provider/provider.dart';

import 'func/providers.dart';

class QRCode extends StatefulWidget {
  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  Check check;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context).check;
    if(check != this.check){
      this.check = check;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("Inspection_results")),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:ListTile(
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
              child:ListTile(
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
              child: qrGenerator('https://naver.com?'+check.toString()),
            )
          ]
        )
      )
    );
  }
}