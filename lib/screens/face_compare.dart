import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';

class CompareFace extends StatefulWidget {
  final String token;

  const CompareFace({super.key, required this.token});

  @override
  State<CompareFace> createState() => ExtendedCompareFace();
}

class ExtendedCompareFace extends State<CompareFace> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  late Map<String, dynamic> pictures;
  late int id;
  XFile? picture;
  @override
  void initState() {
    super.initState();
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Identify Patient"), centerTitle: true),
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
    id = 1;
    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Take Picture of Patient'),
          onPressed: () async {
            var faceCompareUri = Uri.https('${Constants.BASE_URL}', '/api/user/faceCompare/');
            // var faceCompareUri =
            // Uri.parse("${Constants.BASE_URL}/api/user/faceCompare/");
            picture = await availableCameras().then((value) =>
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Camera(token: token, cameras: value))));

            if (picture == null) return;
            String path = picture!.path;
            print("GOOOOOOOOOOOOOOOOOOOOOOOO");
            var request = http.MultipartRequest("POST", faceCompareUri);
            request.headers.addAll({"Authorization": "Token $token"});
            print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");

            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });

            var image = await http.MultipartFile.fromPath("image1", path);
            request.files.add(image);
            http.StreamedResponse response = await request.send();
            print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            var respues = jsonDecode(responseString);
            print(respues);
            print(respues["T"]);
            print("ZOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
            print(responseString);
            Navigator.of(context).pop();
            if (respues['T'] == '-1' || respues['T'] == 'Not Found') {
              const snackbar = SnackBar(
                  content: Text(
                    "No Match",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            else {
              print("KKOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
              print(respues['T']);
              id = int.parse(respues['T'].toString());
              print("ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
              var getPatientUri = Uri.https('${Constants.BASE_URL}', '/api/patients/patientss/$id/');
              //var getPatientUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
              var getImagesUri = Uri.https('${Constants.BASE_URL}', '/api/patients/all/$id/get_images/');
              //var getImagesUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
              final imageRes = await http.get(
                getImagesUri,
                headers: {
                  HttpHeaders.acceptHeader: 'application/json',
                  HttpHeaders.authorizationHeader: 'Token $token',
                },
              );
              final patientRes = await http.get(
                getPatientUri,
                headers: {
                  HttpHeaders.acceptHeader: 'application/json',
                  HttpHeaders.authorizationHeader: 'Token $token',
                },
              );
              print(imageRes.statusCode);
              var decodedPatient = jsonDecode(patientRes.body);
              pictures = json.decode(imageRes.body);
              print(pictures);
              print("Neonlllllllllllllllllllllllllllllllllllll");
              XFile retrievedPicture =
              XFile(pictures['image_lists'][0]['image']);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ShowPatient(
                              token: token,
                              details: decodedPatient,
                              picture: retrievedPicture)));
            }
          }
        )//end of button
        );
  }
}

