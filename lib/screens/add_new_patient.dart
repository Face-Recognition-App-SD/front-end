import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';

import '../utils/constant.dart';


import 'package:camera/camera.dart';

import 'package:rostro_app/screens/show_patient.dart';

import './camera.dart';

//import 'package:flutter_auth_roleperm/screens/userdetailsscreen.dart';
import '../models/patientsdata.dart';

class AddNewPatient extends StatefulWidget {
  final token;

  const AddNewPatient({super.key, required this.token});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;

  late Map<String, dynamic> pictures;
  int id = 1;
  XFile? picture;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  void initState() {
    token = widget.token;
    super.initState();
    // initCamera(widget.patients![0]);
  }

  // // ({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Patient'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg),
              fit: BoxFit.cover,
            ),
          ), //background image
          child: ListView(
            children: <Widget>[
              addTextInfo(),
              AddPhoto(),
              SubmitButton(),
            ],
          ),
        ));
  }

  Widget addTextInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: <Widget>[
        SizedBox(height: 30.0),
        TextFormField(
          controller: firstNameController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'First Name',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        SizedBox(height: 30.0),
        TextFormField(
          controller: lastNameController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'Last Name',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        SizedBox(height: 30.0),
        TextFormField(
          controller: ageController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.numbers_rounded, color: Colors.white70),
            hintText: 'Age',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ]),
    );
  }

  Widget SubmitButton() {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            PatientsData? data = await postPatient(token);
            print('info after login');
            if (data != null) print(data.id);
            setState(() {});
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => Homepage(token: token)),
            //     (Route<dynamic> route) => false);
          },
        ));
  }

  Widget AddPhoto() {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 199, 201, 224),
            shape: BoxShape.rectangle,
            //borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18, 
                  color: Color.fromARGB(30, 0, 0, 0),
                  decoration: TextDecoration.underline,
                  ),
            ),
            child: Text('Add Photo'),
            onPressed: () async {
             cameraButtonSection();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => Homepage(token: token)),
              //     (Route<dynamic> route) => false);
            },
          )),
    );
  }
Container cameraButtonSection() {
    var getPatientUri =
        Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
    var getImagesUri =
        Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');

    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Take Picture of Patient'),
          onPressed: () async {
            picture = await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Camera(token: token, cameras: value))));
            final imageRes = await http.get(
              getImagesUri,
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token ' + token,
              },
            );
            final patientRes = await http.get(
              getPatientUri,
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token ' + token,
              },
            );
            var decodedPatient = jsonDecode(patientRes.body);
            pictures = json.decode(imageRes.body);
            XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
            print(retrievedPicture.path);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ShowPatient(
                        token: token,
                        details: decodedPatient,
                        picture: retrievedPicture)));
          },
        )

        //end of button
        );
  }

  Future<PatientsData?> postPatient(token) async {
    var myProfileUri =
        Uri.parse('${Constants.BASE_URL}/api/patients/patientss/');
    print('come to post data');
    print(token);
    final res = await http.post(myProfileUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token ' + token,
    }, body: {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "age": ageController.text,
    });

    var data = res.body;
    if (res.statusCode == 201) {
      String responseString = res.body;

      setState(() {});

      return patientFromJson(responseString);
    } else {
      print('nothing return');
      return null;
    }
  }
}
