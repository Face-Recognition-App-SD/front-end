

import 'package:camera/camera.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/add_new_patient.dart';
import 'package:rostro_app/screens/firstpage.dart';
import '../screens/regisnew.dart';
import '../screens/login_page.dart';
import '../screens/firstpage.dart';
// import './camera.dart';
// import './patient_list.dart';
// import './get_patient_pictures.dart';
// import '../utils/new_patient_widget.dart';
// import './add_new_patient.dart';


class AdminHome extends StatefulWidget {
  final String? token;
  final String? firstname;
  final String? lastname;

  const AdminHome({super.key, this.token, this.firstname, this.lastname});

  @override
  State<AdminHome> createState() => _AdminHome();
}

class _AdminHome extends State<AdminHome> {
  var bg = './assets/images/bg.jpeg';
  late String? token;
  var patientPictures;
  late String? first_name;
  late String? last_name;
  void initState() {
    token = widget.token;
    first_name = widget.firstname;
    last_name =widget.lastname;
    
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
       
       actions: <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FirstPage()),
          );
        },
        child: Icon(Icons.logout_rounded),
        
      ),
    ),
    
       ],
      ),
     
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
                        'Welcome to Admin Page,',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                        
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  signUpButtonSection(),
                 
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Container signUpButtonSection() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: Text('Create New User', textAlign: TextAlign.left),

        // color: Colors.blueAccent,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisNewFirst()),
          ), //button connects to register page
        },
      ),
    );
  }
}
