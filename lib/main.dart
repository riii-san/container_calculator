import 'package:flutter/material.dart';
import 'data.class.dart';
import 'config.dart';

/*
 TODO : 0.0 → 0 一次対策のみ完了
 TODO : =を連打した時の処理
 TODO : +/- , %
 TODO : 過去の計算結果を削除
 TODO : 過去の計算結果を反映
 TODO : ゴリ押ししているレイアウトを修正
 */

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

// debug
List<Cont> tempList = [];

// 保存している数字を格納
List<data> storeNum = [];

// dataクラスのインスタンス
data? _data;

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

// containerButton要素を格納するリスト
List<String> containerButtonCharacter = ['0','.','=','+'];


class _MyHomePageState extends State<MyHomePage> {

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

    @override
    void initState(){
      super.initState();
    }

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
        currentNum = 0;
      });
    }

    // ACを押した時に全ての値をクリア
    void _clearAllParameter(){
      currentNum = 0;
      beforeNum = 0;
      currentOperator = "";
      setState(() {});
    }

    // 演算子を押した時に=が押された時のために各変数に値を格納しておく
    void _setOperator(String receiveOpe){
      currentOperator = receiveOpe;
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
          // 計算結果保存領域
          Positioned(
            top: _containerSize * 3.5,
            left: 0,
            width: _deviceWidth,
            height: _deviceHeight * 0.7,
            child: DragTarget(builder: (context, candidateData, rejectedData) {
              return Container(
                // TODO : 塗りつぶし消す
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5)
                ),
              );
            }),
          ),
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
                  _setOperator("addition");
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
                child: const Text('+',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
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
                  _setOperator("subtraction");
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
                  _setOperator("multiplication");
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
                  _setOperator("division");
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
          // +/-ボタン TODO : ボタン押された時の処理実装
          Positioned(
            top: _deviceHeight - _containerSize * 5 - _bannerHeight - _space * 4,
            left: _sideSpace + _space * 1 + _containerSize * 1,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){},
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
                child: const Text('+/-',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ),
          ),
          // %ボタン TODO : ボタン押された時の処理実装
          Positioned(
            top: _deviceHeight - _containerSize * 5 - _bannerHeight - _space * 4,
            left: _sideSpace + _space * 2 + _containerSize * 2,
            width: _containerSize,
            height: _containerSize,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: (){},
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
              onDraggableCanceled: (view,offset){
                _cont = Cont(offset,currentNum);
                tempList.add(_cont!);
                print(tempList.length);
                setState(() {});
              },
            ),
          ),

          // 保存した結果を表示する領域
          for(int j = 0; j < tempList.length; j++)
            Positioned(
              // TODO : ドラック&ドロップした座標を入力
              left: tempList[j].pos.dx,
              top: tempList[j].pos.dy,
              child: Draggable(
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
                // 追加部分
                onDraggableCanceled: (view, offset) {
                  setState(() {
                    tempList[j].pos = offset;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
