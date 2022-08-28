import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: const MyHomePage(title: 'container calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 表示ラベルの上書き
bool currentNumOverWriteFlg = true;

// .ドットの有無判定
bool dotFlg = false;

// 現在入力中の数字(文字列型)
String strCurrentNum = "0";

// 現在入力中の数字をdouble型に格納する変数
double dbCurrentNum = 0;

// ラベルの数字をプールする変数
double numPool = 0;

// 列挙子
enum MarksType{
  // ignore: constant_identifier_names
  NON,
  // ignore: constant_identifier_names
  PLUS,
  // ignore: constant_identifier_names
  MINUS,
  // ignore: constant_identifier_names
  MULTIPLIED,
  // ignore: constant_identifier_names
  DEVIDED,
  // ignore: constant_identifier_names
  PERCENT,
  // ignore: constant_identifier_names
  SQRT
}

// 列挙状態の初期値
MarksType mType = MarksType.NON;

// フリー座標の個別インスタンス
Cont? _cont;

// コンテナドラッグ中に選択したlistの要素数を格納する番号
int currentSelectArrayNum = 0;

// debug
List<Cont> contList = [];

// デバイスの横サイズ
late double _deviceWidth;
// デバイスの縦サイズ
late double _deviceHeight;
// 電卓ボタンの文字サイズ
late double _buttonFontSize;
// 現在数字の文字サイズ
late double _currentNumFontSize;
// 保存コンテナの数字文字サイズ
late double _storeContainerNumFontSize;
// 保存コンテナのラベル文字サイズ
late double _storeContainerLabelFontSize;
// コンテナの1辺の長さ
late double _containerSize;
// バナー広告の大きさ
late double _bannerHeight;
// コンテナのスペース
late double _space;
// コンテナ一番サイドのスペース
late double _sideSpace;

// ドラッグ中かどうかを判定するフラグ
bool dragFlg = false;

// 保存した結果がドラッグ中かどうか
bool dragStoreFlg = false;

// 入力中のコンテナにドラッグ可能かどうかを判定するフラグ
bool dropCurrentContainerFlg = false;

// 削除アイコンにドラッグ可能かどうかを判定するフラグ
bool dropDeleteFlg = false;

// 入力したダイアログの値を一時保持する変数
TextEditingController labelTextController = TextEditingController();

// containerButton要素を格納するリスト
List<String> containerButtonCharacter = ['0','.','=','+','1','2','3','-','4','5','6','*','7','8','9','÷','AC','√','％','C'];

// 演算処理
void _exeCalculate(){
  dbCurrentNum = double.parse(strCurrentNum);
  switch(mType)
  {
    case MarksType.NON:
      numPool = dbCurrentNum;
      break;
    case MarksType.PLUS:
      numPool += dbCurrentNum;
      break;
    case MarksType.MINUS:
      numPool -= dbCurrentNum;
      break;
    case MarksType.MULTIPLIED:
      numPool *= dbCurrentNum;
      break;
    case MarksType.DEVIDED:
      numPool /= dbCurrentNum;
      break;
    case MarksType.PERCENT:
      numPool = dbCurrentNum * 0.01;
      break;
    case MarksType.SQRT:
      numPool = sqrt(dbCurrentNum);
      break;
  }
  strCurrentNum = numPool.toString();
  mType = MarksType.NON;
  // .ドット表示をするかどうかを判定
  if(strCurrentNum.substring(strCurrentNum.length-2,strCurrentNum.length) == '.0'){
    strCurrentNum = strCurrentNum.substring(0,strCurrentNum.length-2);
  }
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _deviceWidth = MediaQuery.of(context).size.width;
    // 画面の縦サイズを定義
    _deviceHeight = MediaQuery.of(context).size.height;

    // 電卓ボタンの文字サイズ 20
    _buttonFontSize = _deviceWidth / 20.7;
    // 現在数字の文字サイズ 20
    _currentNumFontSize = _deviceWidth / 20.7;
    // 保存コンテナの数字文字サイズ 18
    _storeContainerNumFontSize = _deviceWidth / 23;
    // 保存コンテナのラベル文字サイズ 20
    _storeContainerLabelFontSize = _deviceWidth / 20.7;

    // コンテナの1辺の長さ
    _containerSize = _deviceWidth * 0.2;
    // バナー広告の大きさ
    _bannerHeight = _deviceWidth * 0.15;
    // コンテナのスペース
    _space = _deviceWidth * 0.025;
    // コンテナ一番サイドのスペース
    _sideSpace = _deviceWidth * 0.125 / 2;

    // 0~9の数字が押された時の処理
    void _numClick(String num){
      print(_deviceWidth);
      setState(() {
        if(currentNumOverWriteFlg){
          strCurrentNum = num;
          if(strCurrentNum != '0'){
            currentNumOverWriteFlg = false;
          }
        }
        else{
          strCurrentNum += num;
        }
      });
    }

    // Cが押された時の処理
    void _clearClick(){
      setState(() {
        strCurrentNum = '0';
        currentNumOverWriteFlg = true;
        dotFlg = false;
      });
    }

    // ACが押された時の処理
    void _allClearClick(){
      setState(() {
        strCurrentNum = '0';
        dbCurrentNum = 0;
        currentNumOverWriteFlg = true;
        dotFlg = false;
        numPool = 0;
        mType = MarksType.NON;
      });
    }

    // .ドットボタンが押された時の処理
    void _dotClick(){
      setState(() {
        if(!dotFlg){
          strCurrentNum += '.';
          dotFlg = true;
          currentNumOverWriteFlg = false;
        }
      });
    }

    // + , - , * , ÷ が押された時の処理
    void _operatorClick(MarksType type){
      setState(() {
        dotFlg = false;
        currentNumOverWriteFlg = true;
        _exeCalculate();
        mType = type;
      });
    }

    // %が押された時の処理
    void _percentClick(){
      setState(() {
        dotFlg = false;
        currentNumOverWriteFlg = true;
        mType = MarksType.PERCENT;
        _exeCalculate();
        mType = MarksType.NON;
      });
    }

    // √が押された時の処理
    void _sqrtClick(){
      setState(() {
        dotFlg = false;
        currentNumOverWriteFlg = true;
        mType = MarksType.SQRT;
        _exeCalculate();
        mType = MarksType.NON;
      });
    }

    // =が押された時の処理
    void _equalClick(){
      setState(() {
        _exeCalculate();
        //mType = MarksType.NON;
        dotFlg = false;
        currentNumOverWriteFlg = true;
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 0
          Positioned(
            top: _deviceHeight - _containerSize - _bannerHeight,
            left: _sideSpace,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('0');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('0',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // .ボタン TODO : ボタン押された時の処理実装
          Positioned(
            top: _deviceHeight - _containerSize - _bannerHeight,
            left: _sideSpace + _space * 1 + _containerSize * 1,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _dotClick();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('.',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // =ボタン
          Positioned(
            top: _deviceHeight - _containerSize - _bannerHeight,
            left: _sideSpace + _space * 2 + _containerSize * 2,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _equalClick();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('=',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // +ボタン
          Positioned(
            top: _deviceHeight - _containerSize - _bannerHeight,
            left: _sideSpace + _space * 3 + _containerSize * 3,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _operatorClick(MarksType.PLUS);
                  },
                // 未選択状態
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.indigo
                ),
                child: Text('+',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              )
            ),
          ),
          // 1ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 2 - _bannerHeight - _space * 1,
            left: _sideSpace,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('1');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('1',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 2ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 2 - _bannerHeight - _space * 1,
            left: _sideSpace + _space * 1 + _containerSize * 1,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('2');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('2',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 3ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 2 - _bannerHeight - _space * 1,
            left: _sideSpace + _space * 2 + _containerSize * 2,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('3');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('3',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // -ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 2 - _bannerHeight - _space * 1,
            left: _sideSpace + _space * 3 + _containerSize * 3,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _operatorClick(MarksType.MINUS);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.indigo
                ),
                child: Text('-',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 4ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 3 - _bannerHeight - _space * 2,
            left: _sideSpace,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('4');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('4',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 5ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 3 - _bannerHeight - _space * 2,
            left: _sideSpace + _space * 1 + _containerSize * 1,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('5');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('5',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 6ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 3 - _bannerHeight - _space * 2,
            left: _sideSpace + _space * 2 + _containerSize * 2,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('6');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('6',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // ×ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 3 - _bannerHeight - _space * 2,
            left: _sideSpace + _space * 3 + _containerSize * 3,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _operatorClick(MarksType.MULTIPLIED);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.indigo
                ),
                child: Text('×',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 7ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 4 - _bannerHeight - _space * 3,
            left: _sideSpace,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('7');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('7',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 8ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 4 - _bannerHeight - _space * 3,
            left: _sideSpace + _space * 1 + _containerSize * 1,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('8');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('8',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // 9ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 4 - _bannerHeight - _space * 3,
            left: _sideSpace + _space * 2 + _containerSize * 2,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _numClick('9');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.white
                ),
                child: Text('9',style: TextStyle(color: Colors.black,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // ÷ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 4 - _bannerHeight - _space * 3,
            left: _sideSpace + _space * 3 + _containerSize * 3,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _operatorClick(MarksType.DEVIDED);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.indigo
                ),
                child: Text('÷',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // ACボタン
          Positioned(
            top: _deviceHeight - _containerSize * 5 - _bannerHeight - _space * 4,
            left: _sideSpace,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _allClearClick();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.blue.shade300
                ),
                child: Text('AC',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // √ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 5 - _bannerHeight - _space * 4,
            left: _sideSpace + _space * 1 + _containerSize * 1,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _sqrtClick();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.blue.shade300
                ),
                child: Text('√',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // %ボタン
          Positioned(
            top: _deviceHeight - _containerSize * 5 - _bannerHeight - _space * 4,
            left: _sideSpace + _space * 2 + _containerSize * 2,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _percentClick();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.blue.shade300
                ),
                child: Text('%',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),
          // Cボタン
          Positioned(
            top: _deviceHeight - _containerSize * 5 - _bannerHeight - _space * 4,
            left: _sideSpace + _space * 3 + _containerSize * 3,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){
                  _clearClick();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    side: const BorderSide(
                        color: Colors.grey,
                        width: 0.25
                    ),
                    primary: Colors.blue.shade300
                ),
                child: Text('C',style: TextStyle(color: Colors.white,fontSize: _buttonFontSize),),
              ),
            ),
          ),

          // ボタンを押下した結果を格納するコンテナ
          Positioned(
            top: _deviceHeight - _containerSize * 5.7 - _bannerHeight - _space * 5,
            left: _sideSpace,
            width: _containerSize * 4 + _space * 3,
            height: _containerSize * 0.7,
            child: Draggable(
              data: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: dropCurrentContainerFlg ? Colors.grey.shade300 : Colors.white,
                  border: Border.all(color: dropCurrentContainerFlg ? Colors.lightGreenAccent :  Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(strCurrentNum,style: TextStyle(color: Colors.black,fontSize: _currentNumFontSize)),
              ),
              feedback: Material(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: _containerSize * 4 + _space * 3,
                  height: _containerSize * 0.7,
                  child: Text(strCurrentNum,style: TextStyle(color: Colors.black.withOpacity(0.2),fontSize: _currentNumFontSize)),
                ),
              ),
              // ドラッグ開始
              onDragStarted: (){
                setState(() {
                  dragFlg = true;
                });
              },
              // ドラッグターゲットに置いたとき
              onDragCompleted: (){
                setState(() {
                  dragFlg = false;
                });
              },
              // ドラッグターゲット以外に置いたとき、すなわち画面上段の計算結果保存領域
              onDraggableCanceled: (view,offset){
                setState(() {
                  dragFlg = false;
                  _cont = Cont(offset,strCurrentNum);
                  contList.add(_cont!);
                  strCurrentNum = '0';
                  currentNumOverWriteFlg = true;
                });
              },
            ),
          ),

          // 各ボタン配置ゾーンのDragTarget
          // ドラッグ中のみオン
          dragFlg ?
            Positioned(
              top: _containerSize * 4.5,
              left: 0,
              width: _deviceWidth,
              height: _deviceHeight * 0.7,
              child: DragTarget(builder: (context, accepted, rejected) {
                return Container();
              }),
            )
          : Container(),

          // 現在の計算結果を格納するコンテナのDragTarget
          // 保存したコンテナがドロップ可能になった時にドラッグ中の色を変更するフラグを更新する
          dragFlg ?
            Positioned(
              top: _containerSize * 3.75,
              left: _sideSpace,
              width: _containerSize * 4 + _space * 3,
              height: _containerSize * 0.7,
              child: DragTarget<Cont>(builder: (context, accepted, rejected) {
                return Container();
              },
                onAccept: (data){
                  setState(() {
                    strCurrentNum = data.num;
                    contList.removeAt(currentSelectArrayNum);
                    _exeCalculate();
                    numPool = 0;
                    mType = MarksType.NON;
                    dropCurrentContainerFlg = false;
                  });
                },
                onWillAccept: (data){
                  setState(() {
                    dropCurrentContainerFlg = true;
                  });
                  return true;
                },
                onLeave: (data){
                  setState(() {
                    dropCurrentContainerFlg = false;
                  });
                },
              ),
            )
              : Container(),

          // 削除アイコンを表示
          dragStoreFlg ?
            Positioned(
              top: _bannerHeight * 0.7,
              left: _deviceWidth * 0.45,
              width: _deviceWidth * 0.1,
              height: _deviceWidth * 0.1,
              child: DragTarget<Cont>(builder: (context, accepted, rejected) {
                return Container(
                  decoration: BoxDecoration(
                      color: dropDeleteFlg ? Colors.grey : Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Icon(
                    Icons.delete_forever,
                    color: dropDeleteFlg ? Colors.white : Colors.grey,
                  ),
                );
              },
                onAccept: (data){
                  setState(() {
                    contList.removeAt(currentSelectArrayNum);
                    dropDeleteFlg = false;
                  });
                },
                onWillAccept: (data){
                  setState(() {
                    dropDeleteFlg = true;
                  });
                  return true;
                },
                onLeave: (data){
                  setState(() {
                    dropDeleteFlg = false;
                  });
                },
              ),
            )
                : Container(),

          // 保存した結果を表示する領域
          for(int j = 0; j < contList.length; j++)
            Positioned(
              left: contList[j].pos.dx,
              top: contList[j].pos.dy,
              child: Draggable(
                data: contList[j],
                feedback: Material(
                  child: Container(
                    width: _containerSize * 4 + _space * 3,
                    height: _containerSize * 0.7,
                    color: Colors.white,
                    // ドラッグ可能な場合は枠線の色を変える
                    child : InputDecorator(
                      decoration: InputDecoration(
                          labelText: contList[j].labelText,
                          labelStyle: TextStyle(
                              color: dropCurrentContainerFlg ? Colors.red :  Colors.grey.shade300,
                              fontSize: _storeContainerLabelFontSize
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              )
                          )
                      ),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(contList[j].num,style: TextStyle(color: Colors.black.withOpacity(0.2),fontSize: _storeContainerNumFontSize)),
                      ),
                    )
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    labelTextController.text = contList[j].labelText;
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context){
                          return CupertinoAlertDialog(
                            title: const Text('Input Label Text'),
                            content: CupertinoTextField(controller: labelTextController,autofocus: true,),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel',style: TextStyle(color: Colors.red),),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    contList[j].labelText = labelTextController.text;
                                    labelTextController.text = "";
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        }
                    );
                  },
                  child: Container(
                    width: _containerSize * 4 + _space * 3,
                    height: _containerSize * 0.7,
                    color: Colors.white,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: contList[j].labelText,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: _storeContainerLabelFontSize
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey
                          )
                        )
                      ),
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(contList[j].num,style: TextStyle(color: Colors.black,fontSize: _storeContainerNumFontSize)),
                        ),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                // ドラッグ開始
                onDragStarted: (){
                  currentSelectArrayNum = j;
                  setState(() {
                    dragFlg = true;
                    dragStoreFlg = true;
                  });
                },
                // DragTargetに置かれた場合は元の位置に戻す
                onDragCompleted: (){
                  setState(() {
                    dragFlg = false;
                    dragStoreFlg = false;
                  });
                },
                // DragTarget以外に置かれた場合、その座標に移動
                onDraggableCanceled: (view, offset) {
                  setState(() {
                    contList[currentSelectArrayNum].pos = offset;
                    dragFlg = false;
                    dragStoreFlg = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
