import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:all_sensors/all_sensors.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/qrcode_UI.dart';
import 'package:mobile/ready/biometricsReady.dart';
import 'package:mobile/ready/sensorReady.dart';
import 'package:provider/provider.dart';
import 'package:mobile/func/Translations.dart';

import 'package:mobile/func/func.dart';

class SensorTest extends StatefulWidget{
  _SensorTestState createState() => _SensorTestState();
}
class _SensorTestState extends State<SensorTest> {
  List<double> accelerometer = new List<double>(3);
  List<double> gyroscope = new List<double>(3);
  double _direction , initDirection;

  int _current = 10;
  Color _color = Colors.white;
  double _size = 40.0;
  String buttons = 'start_test';
  StreamSubscription gyroSub, acceleSub, compassSub, st;
  Check check;

  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    acceleSub =  accelerometerEvents.listen((AccelerometerEvent e) {
      setState(() {
        accelerometer = <double>[rank(e.x,100), rank(e.y,100), rank(e.z,100)];
      });
    });
    gyroSub = gyroscopeEvents.listen((GyroscopeEvent e) {
      setState(() {
        gyroscope = <double>[rank(e.x,1),rank(e.y,1),rank(e.z,1)];
      });
    });
    compassSub = FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction;
        if(initDirection == null && _direction != null ){
          initDirection = _direction;
        }
      });
    });
    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> ProximityQueue()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
        test();
        checkIsCheck();
      });
      return isCheck;
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context, listen: false).check;
    if(check != this.check){
      this.check = check;
    }

  }
  @override
  void dispose(){
    super.dispose();
    acceleSub.cancel();
    gyroSub.cancel();
    compassSub.cancel();
    st.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("sensor"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.broadcastTower),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: timerStyle(_current, _size, _color)
                )
            ),
          ],
        ),
      )
    );
  }

  void test() async{
    await checkAcc(await acc());
    await checkGyro(await gyro());
    await checkCompass(await compass());
  }
  void checkIsCheck() {
    if(check.accelerometer && check.gyroscope && check.compass){
      setState(() {
        isCheck = true;
      });
    }
  }
  Future<bool> acc() async {
    if(accelerometer[0] == null) return false;
    return true;
  }
  Future<void> checkAcc(bool accOk) async => accOk ? Provider.of<Checker>(context, listen: false).checkAccelerometer() : DoNothingAction();

  Future<bool> gyro() async {
    if(gyroscope[0] == null) return false;
    return true;
  }
  Future<void> checkGyro(bool gyroOk) async => gyroOk ? Provider.of<Checker>(context, listen: false).checkGyroscope() : DoNothingAction();

  Future<bool> compass() async {
    if(_direction == null || initDirection == null) return false;
    if(initDirection != _direction) return true;
    return false;
  }
  Future<void> checkCompass(bool compassOk) async => compassOk ? Provider.of<Checker>(context, listen: false).checkCompass() : DoNothingAction();
}

class GeoLocationTest extends StatefulWidget{
  _GeoLocationTestState createState() => _GeoLocationTestState();
}
class _GeoLocationTestState extends State<GeoLocationTest> {
  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  StreamSubscription st;
  bool isCheck = false;

  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;

  Check check;
  String buttons = "start_test";

  @override
  void initState() {
    super.initState();
    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> QRCode()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
      });
      return isCheck;
    });
    _getCurrentLocation();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context, listen: false).check;
    if(check != this.check){
      this.check = check;
      isCheck = check.geolocation;
    }
  }
  @override
  void dispose(){
    super.dispose();
    st.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("geolocation"),),
      body: Container(
        margin: EdgeInsets.all(MYPADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.searchLocation),
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

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        isCheck = true;
        Provider.of<Checker>(context, listen: false).checkGeolocation();
      });
    }).catchError((e) {
    });
  }
}

class ProximityTest extends StatefulWidget{
  _ProximityTestState createState() => _ProximityTestState();
}
class _ProximityTestState extends State<ProximityTest> {
  bool isCheck = false;
  bool isStart = false;

  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;

  bool _proximityValues = false;
  String buttons ='start_test';
  StreamSubscription proxiSub, st;
  Check check;

  @override
  void initState() {
    super.initState();
    proxiSub = proximityEvents.listen((ProximityEvent event){
      setState(() {
        _proximityValues = event.getValue();
        if(_proximityValues) {
          updateProximityState();
        }
      });
    });
    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> AmbientLightQueue()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
      });
      return isCheck;
    });
  }
  void updateProximityState(){
    isCheck =  true;
    Provider.of<Checker>(context, listen: false).checkProximity();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context, listen: false).check;
    if(check != this.check){
      this.check = check;
      isCheck = check.proximity;
    }
  }
  @override
  void dispose(){
    super.dispose();
    proxiSub.cancel();
    st.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: fiveAppbar(Translations.of(context).trans("proximity_sensor"),),
       body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              turnColorIcon(isCheck, Icons.wifi_tethering),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: timerStyle(_current, _size, _color)
                  )
              ),
            ],
          ),
        )
    );
  }
}

class AmbientLightTest extends StatefulWidget{
  _AmbientLightTestState createState() => _AmbientLightTestState();
}
class _AmbientLightTestState extends State<AmbientLightTest> {
  bool isCheck =false;
  bool isStart = false;
  String buttons = 'start_test';
  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;
  StreamSubscription st;

  @override
  void initState() {
    super.initState();
    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> BiometricsQueue()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
      });
      return isCheck;
    });
  }
  @override
  void dispose(){
    super.dispose();
    st.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans("ambient_light_sensor"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            turnColorIcon(isCheck, FontAwesomeIcons.lightbulb),
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


double rank(double x, int scale) {
  return (x * scale).round() / (scale*1.0);
}