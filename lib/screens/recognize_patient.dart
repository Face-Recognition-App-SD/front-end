import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';

class RecognizePatient extends StatefulWidget {
  final String token;

  const RecognizePatient({super.key, required this.token});

  @override
  State<RecognizePatient> createState() => _recognizePatient();
}

class _recognizePatient extends State<RecognizePatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  late Map<String, dynamic> pictures;
  int id = 1;
  XFile? picture;
  @override
  void initState() {
    super.initState();
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
          ],
        ),
      ),
    );
  }
  Container cameraButtonSection() {
    var getPatientUri =  Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
    var getImagesUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
    
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
            final imageRes = await http.get(getImagesUri,
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token '+ token,
              },
            );
            final patientRes = await http.get(getPatientUri,
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token '+ token,
              },
            );
            var decodedPatient = jsonDecode(patientRes.body);
            pictures = json.decode(imageRes.body);
            XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
            print(retrievedPicture.path);
            Navigator.push(context, MaterialPageRoute(builder: (_) => ShowPatient(token: token, details: decodedPatient, picture: retrievedPicture)));
          },
        )

      //end of button
    );
  }
}