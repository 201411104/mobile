import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:mobile/inspection/buttons.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/inspection/sensors.dart';
import '../func/Translations.dart';
import '../func/design.dart';
class DeviceInfo extends StatefulWidget {
  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  List _data = <dynamic>["","",""];

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans('device_info'),),
        backgroundColor: Colors.red[200],
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 70,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(flex: 1,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(MYPADDING),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    "Device info",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .apply(
                                            color: Colors.black,
                                            fontWeightDelta: 2),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.rotate_right,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                      '${Translations.of(context).trans('device_manufacturer')} : ${_data[0]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 2),
                                      
                                    ),
                                    Text(
                                      '${Translations.of(context).trans('device_model')} : ${_data[1]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 2),
                                    ),
                                    Text(
                                      '${Translations.of(context).trans('device_hardward')} : ${_data[2]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(
                                              color: Colors.black,
                                              fontWeightDelta: 2),
                                    ),
                                ]    
                              )
        
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            RaisedButton(
                              child: Text("검사시작"),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeButtonTest()));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(flex: 4),
                  ],
                ),
              ),
            ),
          ]
        )
      )
    );
  }

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
//        _data.addAll({"manufacturer": androidInfo.brand});
//        _data.addAll({"model": androidInfo.model});
//        _data.addAll({"hardware": androidInfo.hardware});
//        _data.addAll({"OS": androidInfo.version.release});
        _data = [
//          androidInfo.version.securityPatch,    // 2018-06-01
//          androidInfo.version.sdkInt,           // 24
//          androidInfo.version.codename,         // REL
//          androidInfo.board,                    // universal7420
//          androidInfo.bootloader,               // G920LKLU3ERG1
          androidInfo.manufacturer,             // samsung
//          androidInfo.brand,                    // samsung
//          androidInfo.device,                   // zerofltelgt
//          androidInfo.display,                  // NRD90M.G920LKLU3ERG1
//          androidInfo.fingerprint,              // samsung/zerofltelgt/zerofltelgt:7.0/NRD90M/G920LKLU3ERG1:user/release-keys
//          androidInfo.hardware,                 // samsungexynos7420
//          androidInfo.host,                     // 21HHAE16
//          androidInfo.id,                       // NRD90M
          androidInfo.model,                    // SM-G920L
//          androidInfo.product,                  // zerofltelgt
//          androidInfo.androidId,                // 89096ec22a2ddcb1
          "Android "+androidInfo.version.release,          // 7.0
        ];
      });
    }
    else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
//        _data.addAll({"manufacturer": "Apple"});
//        _data.addAll({"model": iosInfo.name});
//        _data.addAll({"OS": iosInfo.systemName + " " + iosInfo.systemVersion});
        _data = [
          "Apple",
          iosInfo.name,                         // iPhone 11Pro Max
//          iosInfo.systemName,                   // iOS
          iosInfo.systemName +" "+ iosInfo.systemVersion,                // 13.3
//          iosInfo.model,                        // iPhone
//          iosInfo.localizedModel,               // iPhone
//          iosInfo.identifierForVendor,          // C01CAB09-DE6F-4AC1-87FC-CFC0E29468F1
//          iosInfo.isPhysicalDevice,             // false
//          iosInfo.utsname.version,              // Darwin Kernel Version 19.9.0: Thu Jan 9 20:58:23 PST 2020;root:xnu-6153.81.5~1/RELEASE_X86_64
//          iosInfo.utsname.machine,              // x86_64
//          iosInfo.utsname.nodename,             // JungHyunui-MacBookPro.local
//          iosInfo.utsname.release,              // 19.3.0
//          iosInfo.utsname.sysname               // Darwin
        ];
      });
    }
  }
}
