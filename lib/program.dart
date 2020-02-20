
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/func/Translations.dart';

import 'func/design.dart';

class Program extends StatefulWidget{
  ProgramState createState() => ProgramState();
}
class ProgramState extends State<Program>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fiveAppbar(Translations.of(context).trans("program"),),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(FontAwesomeIcons.nimblr),
              title: Text(Translations.of(context).trans("program"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> ProgramA()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.nimblr),
              title: Text(Translations.of(context).trans("program"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> ProgramB()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.nimblr),
              title: Text(Translations.of(context).trans("program"),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> ProgramC()));
              },
            ),
          ],
        )
    );
  }
}

class ProgramA extends StatefulWidget{
  ProgramAState createState() => ProgramAState();
}
class ProgramAState extends State<ProgramA>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans('program'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(FontAwesomeIcons.nimblr),
                    title: Text(Translations.of(context).trans('program'),),
                  )
                ],
              ),
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}

class ProgramB extends StatefulWidget{
  ProgramBState createState() => ProgramBState();
}
class ProgramBState extends State<ProgramB>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans('program'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(FontAwesomeIcons.nimblr),
                    title: Text(Translations.of(context).trans('program'),),
                  )
                ],
              ),
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}

class ProgramC extends StatefulWidget{
  ProgramCState createState() => ProgramCState();
}
class ProgramCState extends State<ProgramC>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fiveAppbar(Translations.of(context).trans('program'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(FontAwesomeIcons.nimblr),
                    title: Text(Translations.of(context).trans('program'),),
                  )
                ],
              ),
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}