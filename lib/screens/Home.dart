

import 'package:camera/camera.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/add_new_patient.dart';
import './camera.dart';
import './patient_list.dart';
import './get_patient_pictures.dart';
import '../utils/new_patient_widget.dart';
import './add_new_patient.dart';

class Home extends StatefulWidget {
  final String? token;
  final String? firstname;
  final String? lastname;

  const Home({super.key, this.token, this.firstname, this.lastname});

  @override
  State<Home> createState() => _home2State();
}

class _home2State extends State<Home> {
  var bg = './assets/images/bg.jpeg';
  late String? token;
  var patientPictures;
  void initState() {
    token = widget.token;
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      Text(
                        'Welcome to Rostro App',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  // Container(
                  //   decoration: BoxDecoration(
                      
                  //     color: Color.fromARGB(255, 188, 191, 196),
                  //     image: const DecorationImage(
                  //       image: NetworkImage(
                  //           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                        
                  //     ),
                  //     border: Border.all(
                  //       width: 50,
                  //     ),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                    // child: const Text(
                    //   'Want to check out your assigned patients for today',
                    //   textAlign: TextAlign.center,
                    
                     
                    //   style: TextStyle(fontSize: 15, color: Colors.white),
                    // ),
                 // ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
