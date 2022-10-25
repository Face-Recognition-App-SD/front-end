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

  const Home({super.key, this.token});

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
        ), //background image
        // child: ListView(
        //   children: <Widget>[
        //     cameraButtonSection(),
        //     PatientListContainer(),
        //      AddNewPatientButton(),
        //   ],
      //  ),
      ),
      // bottomNavigationBar: NavigationBar(
      //   destinations: const [
      //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //     NavigationDestination(icon: Icon(Icons.list), label: 'Patient'),
      //     NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   onDestinationSelected: (int index){
      //     setState(() {
      //       currentPage = index;
      //     });
      //   },
      //   selectedIndex: currentPage,
      // ),
    );
  }

 
 }
