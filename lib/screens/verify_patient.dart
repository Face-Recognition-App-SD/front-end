import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';

class VerifyPatient extends StatefulWidget {
  final String token;

  const VerifyPatient({super.key, required this.token});

  @override
  State<VerifyPatient> createState() => ExtendVerifyPatient();
}

class ExtendVerifyPatient extends State<VerifyPatient> {
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
      appBar: AppBar(title: const Text("Verify Patient Identity"), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        child: ListView(
          children: <Widget>[
            getIdSection(),
            cameraButtonSection(),
          ],
        ),
      ),
    );
  }
  TextEditingController patientId = TextEditingController();
  Container getIdSection(){
    return Container(
      margin: const EdgeInsets.only(top: 200.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: <Widget>[
        TextFormField(
          controller: patientId,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'Patient ID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 30.0)
      ]),
    );
  }
  Container cameraButtonSection() {

    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Take Picture of Patient'),
          onPressed: () async {
            if (patientId.text.isNotEmpty) {
              id = int.parse(patientId.text);
             var faceVerify = Uri.https(Constants.BASE_URL, '/api/patients/all/$id/faceverify/');
             //var faceVerify = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/faceverify/');
              
              picture = await availableCameras().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Camera(token: token, cameras: value))));
              if (picture==null) return;
              String path = picture!.path;
              String picturePath = "${Constants.BASE_URL}${picture!.path}";
              print(path);
              print("GOOOOOOOOOOOOOOOOOOOOOOOO");
              var request = http.MultipartRequest("POST", faceVerify);
              request.headers.addAll({"Authorization": "Token $token"});
              print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");

              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              var image = await http.MultipartFile.fromPath("image1", picturePath);
              print(image.filename);
              request.files.add(image);
              http.StreamedResponse response = await request.send();
              print(response.statusCode);
              print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
              var responseData = await response.stream.toBytes();
              var responseString = String.fromCharCodes(responseData);
              var respues = jsonDecode(responseString);
              print(respues);
              print("ZOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
              print(responseString);
              Navigator.of(context).pop();
              print(respues['status']);
              print('false');
              print(respues['status'] == 'false');
              if (respues['status'] == false) {
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
                XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
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
          },
        )
      //end of button
    );
  }
}