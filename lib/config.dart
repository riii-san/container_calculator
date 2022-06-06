import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class config{

  // 画面サイズ定義
  late double deviceHeight; // 縦 : 926.0
  late double deviceWidth; // 横 : 428.0

  config(var context){
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }

}