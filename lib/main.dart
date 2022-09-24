import 'package:flutter/material.dart';
import './screens/regisnew.dart';
import './screens/login.dart';
import 'screens/firstpage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(MyApp()); //run MyApp()
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rostro', //title
      home:
          FirstPage(), //starting page links to FirstPage() from firstpage.dart
    );
  }
}
