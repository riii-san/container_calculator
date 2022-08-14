import 'package:flutter/material.dart';
import 'data.class.dart';
import 'config.dart';
import 'dart:math';


/*
 TODO : 0.0 → 0 一次対策のみ完了
 TODO : √ , % , .
 TODO : 過去の計算結果を削除
 TODO : ゴリ押ししているレイアウトを修正
 */

/*
* currentNumの仕様
* ・入力した数字を格納する変数
* ・四則演算が押下された場合はクリアする
* →クリアするのは画面描画後
* ・四則演算を押下して保存済みのコンテナをクリックした時、すなわちbeforeNum ≠ null & currentNum = 0のとき、currentNumに一時的にbeforeNumの値を格納
* →コンテナを計算結果エリア以外に置いた場合はcurrentNumにbeforeNumの値を入れておく
*
* */

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

// 現在の数字を格納
double currentNum = 0;

// 演算中に前の数字を格納
double beforeNum = 0;

// 現在表示中の数字を格納
double currentViewNum = 0;

// 現在選択中の演算子を格納
String currentOperator = "";

// フリー座標の個別インスタンス
Cont? _cont;

// コンテナドラッグ中に選択したlistの要素数を格納する番号
int currentSelectArrayNum = 0;

// debug
List<Cont> tempList = [];

// 保存している数字を格納
List<data> storeNum = [];

// ループ変数
int i = 0;

// デバイスの横サイズ
late double _deviceWidth;
// デバイスの縦サイズ
late double _deviceHeight;
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

// containerButton要素を格納するリスト
List<String> containerButtonCharacter = ['0','.','=','+','1','2','3','-','4','5','6','*','7','8','9','÷','AC','√','％','C'];



class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // 足し算
    const String addition = "addition";

    // 引き算
    const String subtraction = "subtraction";

    // 掛け算
    const String multiplication = "multiplication";

    // 割り算
    const String division = "division";

    _deviceWidth = MediaQuery.of(context).size.width;
    // 画面の縦サイズを定義
    _deviceHeight = MediaQuery.of(context).size.height;
    // コンテナの1辺の長さ
    _containerSize = _deviceWidth * 0.2;
    // バナー広告の大きさ
    _bannerHeight = _deviceWidth * 0.15;
    // コンテナのスペース
    _space = _deviceWidth * 0.025;
    // コンテナ一番サイドのスペース
    _sideSpace = _deviceWidth * 0.125 / 2;

    // 数字入力した時に現在の数字に反映する
    void _inputNum(int num){
      setState(() {
        currentNum *= 10;
        currentNum += num;
      });
    }

    // Cを押した時に現在入力されている数字をクリア
    void _clearCurrentNum(){
      setState(() {
        beforeNum = 0;
        currentNum = 0;
      });
    }

    // ACを押した時に全ての値をクリア
    void _clearAllParameter(){
      setState(() {
        currentNum = 0;
        beforeNum = 0;
        currentOperator = "";
      });
    }

    // %を押した時の計算処理
    //  / 100
    void _inputPercent(){
      setState(() {
        currentNum = currentNum / 100;
      });
    }

    // √を押した時の計算処理
    // 平方根
    void _inputSqrt(){
      setState(() {
        currentNum = sqrt(currentNum);
      });
    }

    // 演算子を押した時に=が押された時のために各変数に値を格納しておく
    void _setOperator(String receiveOpe){
      setState(() {
        currentOperator = receiveOpe;
      });
      beforeNum = currentNum;
      currentNum = 0;
    }

    // =が押された時に演算処理を実施
    void _executeCalc(){
      switch(currentOperator){
        // 足し算
        case addition:
          currentNum = beforeNum + currentNum;
          setState(() {});
          break;
        // 引き算
        case subtraction:
          currentNum = beforeNum - currentNum;
          setState(() {});
          break;
        // 掛け算
        case multiplication:
          currentNum = beforeNum * currentNum;
          setState(() {});
          break;
        // 割り算
        case division:
          currentNum = beforeNum / currentNum;
          setState(() {});
          break;
      }
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
                  _inputNum(0);
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
                child: const Text('0',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                child: const Text('.',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _executeCalc();
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
                child: const Text('=',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _setOperator(addition);
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
                child: const Text('+',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _inputNum(1);
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
                child: const Text('1',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _inputNum(2);
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
                child: const Text('2',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _inputNum(3);
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
                child: const Text('3',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _setOperator(subtraction);
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
                child: const Text('-',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _inputNum(4);
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
                child: const Text('4',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _inputNum(5);
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
                child: const Text('5',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _inputNum(6);
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
                child: const Text('6',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _setOperator(multiplication);
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
                child: const Text('×',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _inputNum(7);
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
                child: const Text('7',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _inputNum(8);
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
                child: const Text('8',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _inputNum(9);
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
                child: const Text('9',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                  _setOperator(division);
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
                child: const Text('÷',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _clearAllParameter();
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
                child: const Text('AC',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _inputSqrt();
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
                child: const Text('√',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _inputPercent();
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
                child: const Text('%',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  _clearCurrentNum();
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
                child: const Text('C',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(currentNum.toString(),style: const TextStyle(color: Colors.black,fontSize: 20)),
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
                  child: Text(currentNum.toString(),style: TextStyle(color: Colors.black.withOpacity(0.2),fontSize: 20)),
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
                  _cont = Cont(offset,currentNum);
                  tempList.add(_cont!);
                  currentNum = 0;
                  beforeNum = 0;
                });
              },
            ),
          ),

          // 各ボタン配置ゾーン
          // ドラッグ中のみオン
          dragFlg ?
            Positioned(
              top: _containerSize * 4.5,
              left: 0,
              width: _deviceWidth,
              height: _deviceHeight * 0.7,
              child: DragTarget(builder: (context, accepted, rejected) {
                return Container(
                  // TODO : 塗りつぶし消す
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5)),
                );
              },
              ),
            )
          : Container(),

          // 現在の計算結果を格納するコンテナ
          dragFlg ?
            Positioned(
              top: _containerSize * 3.75,
              left: _sideSpace,
              width: _containerSize * 4 + _space * 3,
              height: _containerSize * 0.7,
              child: DragTarget<Cont>(builder: (context, accepted, rejected) {
                return Container(
                  // TODO : 塗りつぶし消す
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5)),
                );
              },
                onAccept: (data){
                  setState(() {
                    currentNum = data.num;
                    tempList.removeAt(currentSelectArrayNum);
                    _executeCalc();
                    currentOperator = "";
                  });
                },
              ),
            )
              : Container(),

          // 保存した結果を表示する領域
          for(int j = 0; j < tempList.length; j++)
            Positioned(
              left: tempList[j].pos.dx,
              top: tempList[j].pos.dy,
              child: Draggable(
                data: tempList[j],
                feedback: Material(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    width: _containerSize * 4 + _space * 3,
                    height: _containerSize * 0.7,
                    child: Text(tempList[j].num.toString(),style: TextStyle(color: Colors.black.withOpacity(0.2),fontSize: 20)),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  width: _containerSize * 4 + _space * 3,
                  height: _containerSize * 0.7,
                  child: Text(tempList[j].num.toString(),style: const TextStyle(color: Colors.black,fontSize: 20)),
                ),
                childWhenDragging: Container(),
                // ドラッグ開始
                onDragStarted: (){
                  currentSelectArrayNum = j;
                  currentNum = beforeNum;
                  setState(() {
                    dragFlg = true;
                  });
                },
                // DragTargetに置かれた場合は元の位置に戻す
                onDragCompleted: (){
                  setState(() {
                    dragFlg = false;
                  });
                },
                // DragTarget以外に置かれた場合、その座標に移動
                onDraggableCanceled: (view, offset) {
                  setState(() {
                    tempList[currentSelectArrayNum].pos = offset;
                    dragFlg = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
