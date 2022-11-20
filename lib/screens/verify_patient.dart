import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';
import 'package:exif/exif.dart';

class VerifyPatient extends StatefulWidget {
  final String token;
  final int id;
  const VerifyPatient({super.key, required this.token, required this.id});

  @override
  State<VerifyPatient> createState() => ExtendVerifyPatient();
}

class ExtendVerifyPatient extends State<VerifyPatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  late Map<String, dynamic> pictures;
  late int id = widget.id;
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
            cameraButtonSection(),
          ],
        ),
      ),
    );
  }
  Container cameraButtonSection() {

    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Take Picture of Patient'),
          onPressed: () async {
              Uri faceVerify = Uri();
              if(Constants.BASE_URL == "api.rostro-authentication.com"){
                faceVerify = Uri.https(Constants.BASE_URL, '/api/patients/all/$id/faceverify/');
              }
             else{
                faceVerify = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/faceverify/');
              }
              
              picture = await availableCameras().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Camera(token: token, cameras: value))));
              if (picture==null) return;
              String path = picture!.path;
              File filePic = File(path);
              Uint8List? compressed = await FlutterImageCompress.compressWithFile(filePic.absolute.path);
              final tempDir = await getTemporaryDirectory();
              File file = await File('${tempDir.path}/image.png').create();
              file.writeAsBytesSync(compressed!);
              print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");

              print(file.path);
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
              var image = await http.MultipartFile.fromPath("image", file.path);
              request.files.add(image);
              request.fields['id'] = id.toString();
              http.StreamedResponse response = await request.send();
              var responseData = await response.stream.toBytes();
              var responseString = String.fromCharCodes(responseData);
              var respues = jsonDecode(responseString);
              Navigator.of(context).pop();
              print(respues['status']);
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
                Uri  getPatientUri = Uri();
                if(Constants.BASE_URL == "api.rostro-authentication.com"){
                  getPatientUri = Uri.https('${Constants.BASE_URL}', '/api/patients/patientss/$id/');
                }
                else{
                  getPatientUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
                }
                Uri getImagesUri = Uri();
                if(Constants.BASE_URL == "api.rostro-authentication.com"){
                  getImagesUri = Uri.https('${Constants.BASE_URL}', '/api/patients/all/$id/get_images/');
                }
                else{
                  getImagesUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
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
                                picture: retrievedPicture,
                                isFromAll: true,)));
              }
            }
        )
      //end of button
    );
  }
}