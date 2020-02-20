import 'dart:async';
import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/inspection/sensors.dart';
import 'package:mobile/ready/geolocationReady.dart';
import 'package:provider/provider.dart';
import '../func/Translations.dart';
import '../func/providers.dart';
import 'package:mobile/ready/backCameraReady.dart';

List<CameraDescription> cameras;

class CameraTest extends StatefulWidget{
  CameraTestState createState() => CameraTestState();
}
class CameraTestState extends State<CameraTest>{
  
 var getData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).trans('camera'),),
        ),
        body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(CommunityMaterialIcons.camera_front_variant),
                title: Text(Translations.of(context).trans('front_camera')),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FrontCameraTest()));
                  //camera();
                }
              ),
              ListTile(
                leading: Icon(CommunityMaterialIcons.camera_rear_variant),
                title: Text(Translations.of(context).trans('back_camera')),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BackCameraTest()));
                  //camera();
                }
              )
            ],
          ),
    );
  }
}

class FrontCameraTest extends StatefulWidget{
  
  FrontCameraTestState createState() => FrontCameraTestState();
}
class FrontCameraTestState extends State<FrontCameraTest> with WidgetsBindingObserver{

  CameraController controller;

  @override
  void initState(){
    super.initState();
    setupCameras();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setupCameras() async{
    try{
      cameras = await availableCameras();
      controller = new CameraController(cameras[1], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch(_){
      setState(() {
      });
    }
    setState(() {
    });
  }

  Widget cameraPreview() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text('Please Wait');
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }


  Widget navigationBar(BuildContext context){
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RaisedButton(
            child: Text(Translations.of(context).trans('strange'),),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context)=> BackCameraQueue()),);
              }
            ),
        RaisedButton(
            child: Text(Translations.of(context).trans('non_strange'),),
            onPressed: (){
              Provider.of<Checker>(context, listen: false).checkFrontCamera();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context)=> BackCameraQueue()),);
              }
            )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: cameraPreview(),
                )
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                navigationBar(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class BackCameraTest extends StatefulWidget{
  @override
  BackCameraTestState createState() => BackCameraTestState();
}
class BackCameraTestState extends State<BackCameraTest>{

  CameraController controller;
  bool showCamera = true;

  @override
  void initState(){
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async{
    try{
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch(_){
      setState(() {
      });
    }
    setState(() {
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget cameraPreview() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text('Please Wait');
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }


  Widget navigationBar(BuildContext context){
    return ButtonBar(
      mainAxisSize: MainAxisSize.max, // this will take space as minimum as posible(to center)
      children: <Widget>[
        RaisedButton(
            child: Text(Translations.of(context).trans('strange'),),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context)=> GeoLocationQueue()),);
              }
            ),
        RaisedButton(
            child: Text(Translations.of(context).trans('non_strange'),),
            onPressed: (){
              Provider.of<Checker>(context, listen: false).checkBackCamera();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context)=> GeoLocationQueue()),);
              }
            )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: cameraPreview(),
                )
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                navigationBar(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}