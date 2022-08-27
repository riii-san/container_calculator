import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class Config{

  // 画面サイズ定義
  late double deviceHeight; // 縦 : 926.0
  late double deviceWidth; // 横 : 428.0

  Config(var context){
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }

}


class Cont{
  late Offset pos;
  late String num;
  late String labelText;

  Cont(Offset createPos,String number){
    pos = createPos;
    num = number;
    labelText = "";
  }
}