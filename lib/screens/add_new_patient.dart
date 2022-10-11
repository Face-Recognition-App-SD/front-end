import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/firstpage.dart';
import 'package:rostro_app/screens/homepage.dart';

//import 'package:flutter_auth_roleperm/screens/userdetailsscreen.dart';
import '../models/PatientsData.dart';
class AddNewPatient extends StatelessWidget {
  var bg = './assets/images/bg.jpeg';
  // final String token;


  // const AddNewPatient({super.key, required this.token});
  // // ({Key? key, required this.token}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        decoration:BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        
    ));
  }


}