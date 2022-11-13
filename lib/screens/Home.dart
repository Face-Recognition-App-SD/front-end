import 'package:camera/camera.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/add_new_patient.dart';
import '../models/userlogin.dart';
import './camera.dart';
import './patient_list.dart';
import './get_patient_pictures.dart';
import '../utils/new_patient_widget.dart';
import './add_new_patient.dart';
import '../screens/face_compare.dart';
import '../screens/verify_patient.dart';

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
  late Future<UserLogin?> futureUser;
  var patientPictures;
  void initState() {
    token = widget.token;
  }

  int currentPage = 0;
  String? fn = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ),
        child: homeview(),
      ),
    );
  }

  Widget homeview() {
    fn = widget.firstname;
    return ListView(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
                  child: Image.asset(
                    './assets/images/logo.jpeg',
                    height: 150,
                    width: 200,
                    fit: BoxFit.fitWidth,
                  )),
              Container(
                height: 300,
                width: 300,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(55, 73, 108, 248),
                      Color.fromARGB(52, 163, 163, 172)
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 0.9],
                  ),
                  color: Color.fromARGB(255, 188, 191, 196),
                  // image: const DecorationImage(
                  //   image: NetworkImage(
                  //       'https://imageio.forbes.com/specials-images/imageserve/5dbb4182d85e3000078fddae/0x0.jpg?format=jpg&width=1200'),

                  // border: Border.all(
                  //   width: 50,
                  // ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Text(
                      'Hi,${fn}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Column(
                        children: [
                          const SizedBox(height: 15.0),
                          Container(
                            width: 200,
                            child: ElevatedButton(
                              child: Text('Patient List'),
                              // Within the `FirstRoute` widget
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            PatientList(token: token!)));
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            width: 200,
                            child: ElevatedButton(
                              child: Text('Verify Patient'),
                              // Within the `FirstRoute` widget
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CompareFace(token: token!),
                                    ));
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ],
    );
  }
}
