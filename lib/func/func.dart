import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile/func/design.dart';
import 'package:mobile/func/Translations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/async.dart';

Widget skipButton(bool isCheck, BuildContext context, MaterialPageRoute next){
  return RaisedButton(
    child: Text(Translations.of(context).trans('skip'),),
    onPressed:
    !isCheck ? (){
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          next);
    } : null,
  );
}
Widget startAndConfirm(bool isStart, bool isCheck ,String buttons, BuildContext context, MaterialPageRoute next, Function function) {
  return RaisedButton(
    child:  Text(Translations.of(context).trans(buttons)),
    onPressed:
    !isStart ? () => function() :
    isCheck ? (){
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          next);
    } : null,
  );
}
Widget checkBox(bool isStart, bool isCheck, BuildContext context, String desc){
  return Expanded(
    child: ListView(
      children: <Widget>[
        ListTile(
          leading: isCheck
              ? Icon(Icons.check_box)
              : isStart
              ? CircularProgressIndicator()
              : Icon(Icons.check_box_outline_blank),
          title: Text(Translations.of(context).trans(desc),),
        )
      ],
    ),
//    flex: 2,
  );
}
Widget turnColorIcon(bool isCheck, IconData icons) {
  return Icon(
    icons,
    color: isCheck ? Colors.green : Colors.black,
    size: ICONSIZE,
  );
}

Future<void> pass(BuildContext context, MaterialPageRoute next){
  return Navigator.push(
    context,
    next,
  );
}

StreamSubscription startTimer(bool isCheck,  BuildContext context, MaterialPageRoute next, Function function) {
  CountdownTimer countDownTimer = new CountdownTimer(
    new Duration(seconds: 10),
    new Duration(seconds: 1),
  );

  int _current = 10;
  var sub = countDownTimer.listen(null);
  sub.onData((duration) {
    isCheck = function();
    _current-- ;

    if(isCheck || _current < 1) {
      sub.cancel();
      Navigator.push(context, next);
      return;
    }
  });

  sub.onDone(() {
    sub.cancel();
  });

  return sub;
}

Widget readyButtons(BuildContext context, MaterialPageRoute skip, MaterialPageRoute test){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      RaisedButton(
        child: Text(Translations.of(context).trans('skip'),),
        onPressed: ()=> Navigator.push(
            context,
            skip),
      ),
      RaisedButton(
        child: Text(Translations.of(context).trans('start_test'),),
        onPressed: ()=> Navigator.push(
            context,
            test),
      ),
    ],
  );
}
Widget isCompleteTest(BuildContext context, String string, bool isCheck){
  return Padding(
      padding: EdgeInsets.only(left:MYPADDING),
        child:  ListTile(
          title: Text(Translations.of(context).trans(string),),
          //검사 성공일 경우
          trailing: isCheck ? Icon(Icons.check) : Icon(Icons.clear)
    )
  );
}
Widget qrGenerator(String data){
  return Container(
    alignment: Alignment.center,
    child: QrImage(
      data: data,
      version: QrVersions.auto,
    ),
  );


}