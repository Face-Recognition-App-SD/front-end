import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void anything() {
    print('anbything');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent),
            image: DecorationImage(
              image: AssetImage("assets/images/cat.jpeg"),
              fit: BoxFit.fitHeight,
            ),
          ),

          // EdgeInsets.fromLTRB(left, top, right, bottom)

          //margin: EdgeInsets.all(10),
          // child: Image.asset(
          //   'assets/images/logo.jpeg',
          //   fit: BoxFit.fitWidth,
          // ),
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  // alignment: Alignment.center,
                  top: 60,
                  height: 300,
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.redAccent),
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 450,
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your username',
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: anything,
                        child: Text('blablab'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Text('Rostro App'),
//             Image.asset('assets/images/face-600x900.png')
//           ],
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.lightGreen[600],
//       ),
//       body: Center(
//         child: Text('hey'),
//       ),
//     );
