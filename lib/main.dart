import 'package:flutter/material.dart';
import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    // デバイスのサイズを定義
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 上段黒い枠までの部分
            SizedBox(height: deviceHeight * 0.04,),
            // container 計算結果をおける場所
            SizedBox(height: deviceHeight * 0.20,),
            Container(
              width: deviceWidth * 0.23 * 4,
              height: deviceHeight * 0.075,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20)
              ),
              alignment: Alignment.centerRight,
              child: Text("数字が入ります   ")
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
                    child: const Text('7',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('8',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('9',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('4',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('5',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('6',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('1',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('2',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('3',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                    child: const Text('=',style: TextStyle(color: Colors.black,fontSize: 20),),
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
