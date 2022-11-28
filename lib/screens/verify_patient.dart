import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rostro_app/admins/am_user_detail.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';

class VerifyPatient extends StatefulWidget {
  final String token;
  final int id;
  final bool isSuperUser;
  const VerifyPatient({super.key, required this.token, required this.id, required this.isSuperUser});

  @override
  State<VerifyPatient> createState() => ExtendVerifyPatient();
}

class ExtendVerifyPatient extends State<VerifyPatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  late Map<String, dynamic> pictures;
  late int id = widget.id;
  late bool isSuperUser = widget.isSuperUser;
  XFile? picture;
  @override
  void initState() {
    super.initState();
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Identity"), centerTitle: true),
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
        margin: const EdgeInsets.only(top: 220.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(80),
              backgroundColor: Colors.blue, // <-- Button color
              foregroundColor: Colors.white, // <-- Splash color
            ),
            child: const Text('Take Picture', style: TextStyle(fontSize: 22),),
            onPressed: () async {
              Uri faceVerify = Uri();
              if(Constants.BASE_URL == "api.rostro-authentication.com"){
                faceVerify = Uri.https(Constants.BASE_URL, '/api/patients/all/$id/faceverify/');
              }
              else if(!isSuperUser){
                faceVerify = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/faceverify/');
              }
              else{
                faceVerify = Uri.parse('${Constants.BASE_URL}/api/admin/users/$id/faceverify/');
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

              var request = http.MultipartRequest("POST", faceVerify);
              request.headers.addAll({"Authorization": "Token $token"});

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
                const snackbar = SnackBar(content: Text("Match Found!", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Uri  getPatientUri = Uri();
                if(Constants.BASE_URL == "api.rostro-authentication.com"){
                  getPatientUri = Uri.https(Constants.BASE_URL, '/api/patients/patientss/$id/');
                }
                else if(!isSuperUser){
                  getPatientUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
                }
                else{
                  getPatientUri = Uri.parse('${Constants.BASE_URL}/api/admin/users/$id/');
                }
                Uri getImagesUri = Uri();
                if(Constants.BASE_URL == "api.rostro-authentication.com"){
                  getImagesUri = Uri.https(Constants.BASE_URL, '/api/patients/all/$id/get_images/');
                }
                else if(!isSuperUser){
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
                if (!isSuperUser) {
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
                else{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UserDetail(token: token, id: id)));
                }
              }
            }
        )
      //end of button
    );
  }
}