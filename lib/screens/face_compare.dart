import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';
import '../utils/Glassmorphism.dart';

class CompareFace extends StatefulWidget {
  final String token;
  final bool isSuperUser;
  const CompareFace({super.key, required this.token, required this.isSuperUser});

  @override
  State<CompareFace> createState() => ExtendedCompareFace();
}

class ExtendedCompareFace extends State<CompareFace> {
  var bg = './assets/images/bg1.gif';
  late String token;
  late Map<String, dynamic> pictures;
  late int id;
  late bool isSuperUser = widget.isSuperUser;
  XFile? picture;
  @override
  void initState() {
    super.initState();
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    print("JOJ");
    print(isSuperUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Identify Patient"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
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
      child: Glassmorphism(
        blur: 20,
        opacity: 0.1,
        radius: 50.0,
        child: TextButton(
          // child: const Text('Take Picture of Patient'),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: const Text(
              "Take Picture of the Patient",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          onPressed: () async {
            print(isSuperUser);
            print("HOHOHOHOHOHOHOOHOHOHOOHH");
            Uri faceCompareUri = Uri();
            if (Constants.BASE_URL == "api.rostro-authentication.com") {
              faceCompareUri =
                  Uri.https(Constants.BASE_URL, '/api/user/faceCompare/');
            } else if(!isSuperUser) {
              faceCompareUri = Uri.parse("${Constants.BASE_URL}/api/user/faceCompare/");
            }
            else{
              print("HAHAHAHAHAHAHAAHAHAHHAHAHAHAHAHA");
              faceCompareUri = Uri.parse("${Constants.BASE_URL}/api/admin/user/face_recognize/");
            }
            picture = await availableCameras().then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Camera(token: token, cameras: value),
                ),
              ),
            );
            print(faceCompareUri);
            print("JOJOJOJOJOJOOJOJOJOJOJOJOJOJOJJOJOJOJOJO");
            if (picture == null) return;
            String path = picture!.path;
            var request = http.MultipartRequest("POST", faceCompareUri);
            request.headers.addAll(
              {"Authorization": "Token $token"},
            );

            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );

            var image = await http.MultipartFile.fromPath("image1", path);
            request.files.add(image);
            print(request.fields);
            print(request.files);
            print(request.url);
            print(path);
            print(request.headers);
            http.StreamedResponse response = await request.send();
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            var respues = jsonDecode(responseString);
            print(respues);
            print("ZOZOZOZOZOZOZOZOZOZOOZOZOZOZOZZOZOOZ");
            Navigator.of(context).pop();
            if (respues['T'] == -1 || respues['T'] == 'Not Found') {
              const snackbar = SnackBar(
                content: Text(
                  "No Match",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            } else {
              id = int.parse(respues['T'].toString(),);
              Uri getPatientUri = Uri();
              if (Constants.BASE_URL == "api.rostro-authentication.com") {
                getPatientUri = Uri.https(
                    Constants.BASE_URL, '/api/patients/patientss/$id/');
              } else if(!isSuperUser){
                getPatientUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
              }else{
                print("JJOJOJOJOJOJOJOJOJOJO");
                getPatientUri = Uri.parse('${Constants.BASE_URL}/api/admin/users/$id/');
              }
              Uri getImagesUri = Uri();
              if (Constants.BASE_URL == "api.rostro-authentication.com") {
                getImagesUri = Uri.https(Constants.BASE_URL, '/api/patients/all/$id/get_images/');
              } else if(!isSuperUser){
                getImagesUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
              }
              else{
                getImagesUri = Uri.parse('${Constants.BASE_URL}/api/admin/users/$id/get_images/');
              }
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
              var decodedPatient = jsonDecode(patientRes.body);
              pictures = json.decode(imageRes.body);
              XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShowPatient(
                    token: token,
                    details: decodedPatient,
                    picture: retrievedPicture,
                    isFromAll: true,
                  ),
                ),
              );
            }
            // child:Container()
          },
        ), //end of button
      ),
    );
  }
}
