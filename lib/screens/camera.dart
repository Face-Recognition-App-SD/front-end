import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera>{
  @override
  Widget build(BuildContext context) {
    var bg = './assets/images/bg.jpeg';
    return Scaffold(
      appBar: AppBar( title: Text('Take A Picture'),),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,

          ),
        ),

      ),
    );
  }
}