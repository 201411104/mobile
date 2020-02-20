
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:mobile/func/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading/loading.dart';
import 'package:mobile/inspection/autoinspection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile/qrcode_UI.dart';

const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

class VersionsTest extends StatefulWidget{
  VersionsTestState createState() => VersionsTestState();
}

class VersionsTestState extends State<VersionsTest>{
  
  String _version = '';
  String currentVersion = '1.0.0';
  String text = '업데이트 정보를 확인 중입니다.';
  String text2 = '';
  String url;

  void initState(){
    super.initState();
    if(Platform.isIOS) {url = APP_STORE_URL; text2 = '앱스토어';}
    else if(Platform.isAndroid) {url = PLAY_STORE_URL; text2 = '플레이스토어';}
    Future.delayed(Duration(seconds: 2),(){versionCheck();});
  }

  versionCheck() async{
    String version = await GetVersion.projectVersion;
    setState(()=>_version = version);
    if(version==currentVersion){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> QRCode()));
    }
    else{
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildAboutDialog(context),
    );
    }
  }

  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('업데이트가 필요합니다.'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('${text2}로 가기'),
            onPressed: () => _launchURL(url),
          )
        ],
      )
    );
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: fiveAppbar('버전 검사'),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Center(
                child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: Colors.blue,),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(text),
            ),
            Expanded(
              flex: 1,
              child: Text('현재 버전 : $_version'),
            ),
            Expanded(
              flex: 1,
              child: Text('최신 버전 : $currentVersion'),
            ),
          ],
        )
      )
    );
  }
}