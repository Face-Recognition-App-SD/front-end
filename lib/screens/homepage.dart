import 'package:camera/camera.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import './camera.dart';
import './patient_list.dart';
import './get_patient_pictures.dart';



class Homepage extends StatefulWidget {
  final String token;

  const Homepage({super.key, required this.token});

  @override
  State<Homepage> createState() => _homeState();
}

class _homeState extends State<Homepage> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  var patientPictures;
  void initState() {
    token = widget.token;
  }

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
        child: ListView(
          children: <Widget>[
              
           cameraButtonSection(),
            PatientListContainer(),
     
          ],
        ),
      ),
    );
  }

Container welcomeContainer(){
  return Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
         child: ClipRRect(
                child: Text('tem'),
              ),
        

  );
}
  Container cameraButtonSection() {
  
    print(token);
    print("inside camera button");
    return Container(
        margin: EdgeInsets.only(top: 50.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('Add User Pictures'),
          onPressed: (){
            patientPictures = Navigator.push(context, MaterialPageRoute(builder: (_) => GetPatientPictures(token: token)));
          },
          // Within the `FirstRoute` widget
          /*onPressed: () async {
            await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Camera(token: token, cameras: value))));
          },*/
        )

        //end of button
        );
  }

  Container PatientListContainer() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('PatientList'),
          // Within the `FirstRoute` widget
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => PatientList(token: token)));
          },
        ));
  }

  
}
