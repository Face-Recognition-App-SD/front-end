import 'package:flutter/material.dart';
import './register.dart';
import './login.dart';
import './firstpage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rostroo',
      home: FirstPage(),
    );
  }
}
