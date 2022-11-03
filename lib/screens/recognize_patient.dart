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
            id = int.parse(patientId.text);
            var getPatientUri =  Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
            var getImagesUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
            var faceCompareUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/faceverify/');
            picture = await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Camera(token: token, cameras: value))));

            final imageRes = await http.get(getImagesUri,
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token $token',
              },
            );
            final patientRes = await http.get(getPatientUri,
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token $token',
              },
            );
            if (picture==null) return;
            String path = picture!.path;

            var request = http.MultipartRequest("POST", faceCompareUri);
            request.headers.addAll({"Authorization": "Token $token"});
            request.fields['id'] = id.toString();
            var image = await http.MultipartFile.fromPath("image", path);
            request.files.add(image);
            http.StreamedResponse response = await request.send();

            var decodedPatient = jsonDecode(patientRes.body);
            pictures = json.decode(imageRes.body); 
            
            XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            if(responseString.substring(0, 14) == '{"status":true'){
              String foundID =  id.toString();
              Navigator.push(context, MaterialPageRoute(builder: (_) => ShowPatient(token: token, id: foundID, details: decodedPatient, picture: retrievedPicture)));
            }
            else{
              const snackbar = SnackBar(content: Text("No Match", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }

          },
        )
      //end of button
    );
  }
}