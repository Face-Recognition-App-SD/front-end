import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var bg = './assets/images/bg.jpeg';
    return Scaffold(
      appBar: AppBar( title: Text('Homepage'),),
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