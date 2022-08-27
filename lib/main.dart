import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var background;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
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
            ],
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
