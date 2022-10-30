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

  TextEditingController PatientID = new TextEditingController();
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
           // textSection(),

            compareFace(),
          ],
        ),
      ),
    );
  }

  // Container textSection() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: Column(
  //       children: <Widget>[
  //         TextFormField(
  //           controller: PatientID,
  //           cursorColor: Colors.white,
  //           style: TextStyle(color: Colors.white70),
  //           decoration: const InputDecoration(
  //             icon: Icon(Icons.email, color: Colors.white70),
  //             hintText: 'PatientID',
  //             border: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white70)),
  //             hintStyle: TextStyle(color: Colors.white70),
  //           ),
  //         ),
  //         const SizedBox(height: 30.0),
  //       ],
  //     ),
  //   );
  // }

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

  Container compareFace() {
    var faceCompareUri =
        Uri.parse('${Constants.BASE_URL}/api/user/faceCompare/');
       print('inside Compare');
    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Compare Faces'),
          onPressed: () async {
          //   print('picture path $picture.path');
         //   if (picture == null) return;
        //    String path = picture!.path;
          String path = 'https://assets.vogue.in/photos/5ce43f575d1186a07a7f5018/2:3/w_2560%2Cc_limit/feature67.jpg';
            final File patientPicture = File(path);
            var request = http.MultipartRequest("POST", faceCompareUri);
            request.headers.addAll({"Authorization": "Token $token"});
            // var image1 = await http.MultipartFile.fromPath(
            //     "image1", patientPicture.path);
                  var image1 = await http.MultipartFile.fromPath(
                "image1",path);
            http.StreamedResponse response = await request.send();
            print('resonse code $response.statusCode');
            if (response.statusCode == 200){
               var decodedPatient = jsonDecode(response.toString());
               print(decodedPatient);
            }
            else 
            {
                throw Exception('Failed to load data');
            }
              
          },
        ));
  }
}
