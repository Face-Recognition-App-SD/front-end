import 'package:flutter/material.dart';
import 'package:rostro_app/screens/homepage.dart';

import 'screens/regisnew.dart';


import 'screens/firstpage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  runApp(MyApp()); //run MyApp()
}

class MyApp extends StatelessWidget {
   var bg = './assets/images/bg.jpeg';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rostro', //title
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        backgroundColor: const Color.fromARGB(255, 4, 20, 59),
        //primaryColor: Color.fromARGB(255, 7, 28, 83),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black
          ),
          bodyText2: const TextStyle(fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF598BED)
          ),
          headline2: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6D747A),
              ),
          headline1: const TextStyle(
              color: Colors.black,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),

      ),
      home: FirstPage(), //starting page links to FirstPage() from firstpage.dart
    );
  }
}
