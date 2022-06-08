import 'package:flutter/material.dart';
import 'data.class.dart';

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

// 保存している数字を格納
List<data> storeNum = [];

// dataクラスのインスタンス
data? _data;




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

    //var position = const Offset(0, 0);

    // デバイスのサイズを定義
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 上段黒い枠までの部分
            SizedBox(height: deviceHeight * 0.05,),
            // 全削除ボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(onPressed: ()
                    {
                      setState(() {
                        storeNum.clear();
                      });
                    },
                    icon: const Icon(Icons.restore_from_trash_outlined,color: Colors.grey,)
                ),
                SizedBox(width: deviceWidth * 0.025,),
              ],
            ),
            // container 計算結果をおける場所
            DragTarget<String>(
              builder: (context, accepted, rejected) {
                return SizedBox(
                  width: deviceWidth * 0.8,
                  height: deviceHeight * 0.2,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                          itemCount: storeNum.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              key: UniqueKey(),
                              child: (
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                            width: deviceWidth * 0.8,
                                            height: deviceHeight * 0.05,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey.shade400),
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: Text(storeNum[index].num,style: const TextStyle(color: Colors.grey,fontSize: 18),)
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SizedBox(width: deviceWidth * 0.05,),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(height: deviceHeight * 0.0125,),
                                                SizedBox(
                                                    width: deviceWidth * 0.7,
                                                    height: deviceHeight * 0.025,
                                                    child: TextField(
                                                      style: const TextStyle(color: Colors.grey,fontSize: 16),
                                                      controller: storeNum[index].valueController,
                                                      decoration: const InputDecoration.collapsed(
                                                        hintText: "",
                                                        border: InputBorder.none,
                                                      ),
                                                    )
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: deviceHeight * 0.005,)
                                  ],
                                )
                              ),
                              onDismissed: (direction){
                                setState(() {
                                  storeNum.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                );
              },
              onAccept: (inputData) {
                _data = new data();
                _data?.num = inputData;
                storeNum.add(_data!); // 受け側のデータ
                currentNum = 0;
                setState(() {});
              },
            ),
            SizedBox(height: deviceHeight * 0.025,),
            Draggable(
              data: (currentNum - currentNum.toInt() == 0) ? currentNum.toInt().toString() + '   ' : currentNum.toString() + '   ',
              child: Container(
                width: deviceWidth * 0.23 * 4,
                height: deviceHeight * 0.075,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)
                ),
                alignment: Alignment.centerRight,
                child: (currentNum - currentNum.toInt() == 0) ? Text(currentNum.toInt().toString() + '   ',style: const TextStyle(fontSize: 24),) : Text(currentNum.toString() + '   ',style: const TextStyle(fontSize: 24),)
              ),
              feedback: Container(
                  width: deviceWidth * 0.75,
                  height: deviceHeight * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  alignment: Alignment.centerRight,
                  child: (currentNum - currentNum.toInt() == 0) ? Material(child: Text(currentNum.toInt().toString() + '   ',style: const TextStyle(color: Colors.grey,fontSize: 24),)) : Material(child: Text(currentNum.toString() + '   ',style: const TextStyle(color: Colors.grey,fontSize: 24),))
              ),
            ),
            SizedBox(height : deviceWidth * 0.03,),
            // AC , +/- , % , C
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                        primary: Colors.blue
                    ),
                    child: const Text('AC',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                        primary: Colors.blue
                    ),
                    child: const Text('+/-',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                        primary: Colors.blue
                    ),
                    child: const Text('%',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                        primary: Colors.blue
                    ),
                    child: const Text('C',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ],
            ),
            SizedBox(height : deviceWidth * 0.01,),
            // 7 , 8 , 9 , ÷
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
              ],
            ),
            SizedBox(height : deviceWidth * 0.01,),
            // 4 , 5 , 6 , ×
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
              ],
            ),
            SizedBox(height : deviceWidth * 0.01,),
            // 1 , 2 , 3 , -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
              ],
            ),
            SizedBox(height : deviceWidth * 0.01,),
            // 0 , . , = , +
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                        primary: Colors.white
                    ),
                    child: const Text('.',style: TextStyle(color: Colors.black,fontSize: 20),),
                  ),
                ),
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
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
                SizedBox(width: deviceWidth * 0.01,),
                SizedBox(
                  width:  deviceWidth * 0.225,
                  height: deviceWidth * 0.225,
                  child: ElevatedButton(
                    onPressed: (){
                      _setOperator(addition);
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
