import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_version/get_version.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mobile/announcement.dart';
import 'package:mobile/inspection/autoinspection.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/qrcode_UI.dart';
import 'package:mobile/inspection/deviceinformation.dart';
import 'package:mobile/version.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'inspection/camera.dart';
import 'func/Translations.dart';

//WidgetsFlutterBinding.ensureInitialized();

const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

void main() async{
    try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Checker(),),

      ],
      child: Consumer<Checker> (
        builder: (context, check, _){
          return MaterialApp(
            title: 'PineApple',
            theme: ThemeData(
            ),
            home: MyHomePage(title: 'PineApple Main'),

            // 언어팩 내장
            supportedLocales : [
              const Locale('en', 'US'),
              const Locale('ko', 'KR'),
              const Locale('vi', 'VI')
            ],
            localizationsDelegates: [
              const TranslationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],

            localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
              if (locale == null) {
                debugPrint("*language locale is null!");
                return supportedLocales.first;
              }
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  debugPrint("*language ok $supportedLocale");
                  return supportedLocale;
                }
              }
              debugPrint("*language to fallback ${supportedLocales.first}");
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Ready()));
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
              child: RaisedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Ready()));},
              )
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

class Ready extends StatefulWidget{
  ReadyState createState() => ReadyState();
}

class ReadyState extends State<Ready> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fiveAppbar('ready'),
        body: ListView(
          children: <Widget>[
            /*
            ListTile(
                leading: Icon(FontAwesomeIcons.fingerprint),
                title: Text(Translations.of(context).trans('biometrics'),),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BiometricsTest()));
                }
            ),
            ListTile(
                leading: Icon(FontAwesomeIcons.headphonesAlt),
                title: Text(Translations.of(context).trans("headset_on_off"),),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HeadsetTest()));
                }
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.sync),
              title: Text(Translations.of(context).trans("communication"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> WifiTest()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.batteryThreeQuarters),
              title: Text(Translations.of(context).trans("battery"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> BatteryTest()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.broadcastTower),

              title: Text(Translations.of(context).trans("sensor"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> SensorTest()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.handPointUp),
              title: Text(Translations.of(context).trans("touch"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> Draw()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.camera),
              title: Text(Translations.of(context).trans("camera"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> CameraTest()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.phoneVolume),
              title: Text(Translations.of(context).trans("speaker"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> SpeakerTest()));
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text(Translations.of(context).trans("device_info"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> DeviceInfoTest()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.search),
              title: Text(Translations.of(context).trans("program"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> Program()));
              },
            ),
               //UI Test
            Center(
              child: Text('------------------------------------------------------'),
            ),
            ListTile(
                leading: Icon(FontAwesomeIcons.bullseye),
                title: Text(Translations.of(context).trans('button_UI'),),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> ButtonUI()));
                }
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.sync),
              title: Text(Translations.of(context).trans("communication_UI"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> CommunicationUI()));
              },
            ),

             */
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text(Translations.of(context).trans("start_test"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> DeviceInfo()));
              },
            ),
            ListTile(
              title: Text("qrcode_UI 테스트"),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> QRCode()));
              },
            ),
            ListTile(
              title: Text("test"),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> Announce()));
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('auto test'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> AutoInspection()));
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('version test'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> VersionsTest()));
              },
            ),
          ],
        )
    );
  }
}