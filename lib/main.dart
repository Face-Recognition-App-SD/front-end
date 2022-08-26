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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rostro'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo.jpeg',
              scale: 0.8,
              fit: BoxFit.cover,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          width: double.infinity,
          margin: EdgeInsets.all(10),
          // EdgeInsets.fromLTRB(left, top, right, bottom)
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            margin: EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/logo.jpeg',
              scale: 1,
              fit: BoxFit.cover,
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
