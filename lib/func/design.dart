import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

final MYPADDING = 20.0;
final SPACESIZE = 300.0;
final BOXWIDTH = 20.0;
final APPBARFONTSIZE = 25.0;
final FONTSIZE = 20.0;
final ICONSIZE = 150.0;

GradientAppBar fiveAppbar (String title){
  return GradientAppBar(
    title: Text(title, style: TextStyle(fontSize: APPBARFONTSIZE)),
      backgroundColorStart: Colors.red[700],
      backgroundColorEnd: Colors.orange[700],
    );
}

Widget timerStyle(int _current, double _size, Color _color){
  return BorderedText(
    strokeWidth: 2.0,
    child: Text(
      '$_current',
      style: TextStyle(
        fontSize: _size,
        color: _color,
      )
    )
  );
}