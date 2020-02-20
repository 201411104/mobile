import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/sounds.dart';
import 'package:mobile/ready/biometricsReady.dart';
import 'package:mobile/ready/soundsReady.dart';
import 'package:provider/provider.dart';

import 'package:mobile/func/func.dart';
import 'package:mobile/main.dart';
import 'package:mobile/func/providers.dart';
import 'package:mobile/func/Translations.dart';

class BiometricsTest extends StatefulWidget{
  BiometricsTestState createState() => BiometricsTestState();
}
class BiometricsTestState extends State<BiometricsTest>{
  final LocalAuthentication auth = LocalAuthentication();
  bool _canBiometry = false;
  int _current = 10;
  double _size = 40.0;
  Color _color = Colors.white;
  String kindOfBio = "null";
  String fpStatus = 'Default Value';
  String fpState = 'fingerprint';
  String buttons = 'start_test';
  StreamSubscription st;
  Check check;

  Future<void> canCheckBiometrics() async {
    bool canBiometry = await auth.canCheckBiometrics;
    setState(() {
      _canBiometry = canBiometry;
    });
  }
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  bool isCheck = false;
  bool isStart = false;

//  var auth = LocalAuthentication();

  @override
  void initState(){
    super.initState();

    st = startTimer(isCheck,context,MaterialPageRoute(builder: (context)=> HeadsetQueue()),(){
      setState(() {
        _current--;
        if(_current>5) _color = Colors.red[(11-_current)*100];
        else _size = (9-_current)*10.0;
      });
      return isCheck;
    });

//    canCheckBiometrics();
//    _getAvailableBiometrics();
    _authenticate();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final check = Provider.of<Checker>(context).check;
    if(check != this.check){
      this.check = check;
    }
  }
  @override
  void dispose(){
    super.dispose();
    st.cancel();
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          kindOfBio = "Face Id";
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          kindOfBio = "Touch Id";
        }
      }
      else {
        // Android
        kindOfBio = "Android";
      }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

//    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      if(authenticated)
        Provider.of<Checker>(context, listen: false).checkBiometric();
      isCheck = authenticated;
//      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    _authorized = "Authentication is Stopped";
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("fingerprint"),),
        body: Container(
          child: Column(
              children: <Widget>[
                turnColorIcon(isCheck, FontAwesomeIcons.fingerprint),
                Expanded(
                  child:  Container(
                      alignment: Alignment.center,
                      child: timerStyle(_current, _size, _color)
                  )
                ),
                RaisedButton(
                  onPressed: _authenticate,
                )
              ]
          )
      ),
    );
  }
}