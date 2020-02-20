import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Check{
  bool _biometric = false;
  bool _homeButton = false;
  bool _volumeUp = false;
  bool _volumeDown = false;
  bool _lockButton = false;
  bool _sim = false;
  bool _wifi = false;
  bool _bluetooth = false;
  bool _headsetOn = false;
  bool _headsetOff = false;
  bool _battery = false;
  bool _accelerometer = false;
  bool _gyroscope = false;
  bool _compass = false;
  bool _geolocation = false;
  bool _proximity = false;
  bool _ambientLight = false;
  bool _touch = false;
  bool _frontCamera = false;
  bool _backCamera = false;

  bool get biometric => _biometric;
  bool get homeButton => _homeButton;
  bool get volumeUp => _volumeUp;
  bool get volumeDown => _volumeDown;
  bool get lockButton => _lockButton;
  bool get sim => _sim;
  bool get wifi => _wifi;
  bool get bluetooth => _bluetooth;
  bool get headsetOn => _headsetOn;
  bool get headsetOff => _headsetOff;
  bool get battery => _battery;
  bool get accelerometer => _accelerometer;
  bool get gyroscope => _gyroscope;
  bool get compass => _compass;
  bool get geolocation => _geolocation;
  bool get proximity => _proximity;
  bool get ambientLight => _ambientLight;
  bool get touch => _touch;
  bool get frontCamera => _frontCamera;
  bool get backCamera => _backCamera;

  @override
  String toString(){
    List<Map<String, bool>> aaa = new List<Map<String, bool>>();
    aaa.add({"homeButton": homeButton});
    aaa.add({"lockButton": lockButton});
    aaa.add({"volumeButton": volumeDown && volumeUp});
    aaa.add({"wifi": wifi});
    aaa.add({"bluetooth": bluetooth});
    aaa.add({"sim": sim});
    aaa.add({"headset": headsetOff && headsetOn});
    aaa.add({"geolocaion": geolocation});
    aaa.add({"accelerometer": accelerometer});
    aaa.add({"gyroscope": gyroscope});
    aaa.add({"compass": compass});
    aaa.add({"proximity": proximity});
    aaa.add({"ambientLight": ambientLight});
    aaa.add({"touch": touch});
    aaa.add({"frontCamera": frontCamera});
    aaa.add({"backCamera": backCamera});
    aaa.add({"biometrics": biometric});

    return "${aaa.toString()}";
  }
}
class Checker with ChangeNotifier {
  Check check = Check();

  void checkBiometric() {
    check._biometric = true;
    notifyListeners();
  }
  void checkHomeButton() {
    check._homeButton = true;
    notifyListeners();
  }
  void checkVolumeUp() {
    check._volumeUp = true;
    notifyListeners();
  }
  void checkVolumeDown() {
    check._volumeDown = true;
    notifyListeners();
  }
  void checkLockButton() {
    check._lockButton = true;
    notifyListeners();
  }
  void checkSim() {
    check._sim = true;
    notifyListeners();
  }
  void checkWifi() {
    check._wifi = true;
    notifyListeners();
  }
  void checkBluetooth() {
    check._bluetooth = true;
    notifyListeners();
  }
  void checkHeadsetOn() {
    check._headsetOn = true;
    notifyListeners();
  }
  void checkHeadsetOff() {
    check._headsetOff = true;
    notifyListeners();
  }
  void checkBattery() {
    check._battery = true;
    notifyListeners();
  }
  void checkAccelerometer() {
    check._accelerometer = true;
    notifyListeners();
  }
  void checkGyroscope() {
    check._gyroscope = true;
    notifyListeners();
  }
  void checkCompass() {
    check._compass = true;
    notifyListeners();
  }
  void checkGeolocation() {
    check._geolocation = true;
    notifyListeners();
  }
  void checkProximity() {
    check._proximity = true;
    notifyListeners();
  }
  void checkAmbientLight() {
    check._geolocation = true;
    notifyListeners();
  }
  void checkTouch() {
    check._touch = true;
    notifyListeners();
  }
  void checkFrontCamera() {
    check._frontCamera = true;
    notifyListeners();
  }
  void checkBackCamera() {
    check._backCamera = true;
    notifyListeners();
  }

}