import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';

class PatientDetail extends StatefulWidget {
  final String token;
  final String id;
  final bool isFromALl;
  final bool? is_superuser;
  const PatientDetail(
      {super.key,
     this.is_superuser,
      required this.token,
      required this.id,
      required this.isFromALl});

  @override
  State<PatientDetail> createState() => _PatientDetail();
}

class _PatientDetail extends State<PatientDetail> {
  var bg = './assets/images/bg1.gif';
  late String token;
  late Map<String, dynamic> pictures;
  late String id;
  XFile? picture;
  late bool isFromAll = widget.isFromALl;
  late bool? is_superuser = widget.is_superuser;
  @override
  void initState() {
    super.initState();
    token = widget.token;
    id = widget.id;
    getPatientDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Verify Patient Identity"), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
      ),
    );
  }

  void getPatientDetail(String any) async {
    setState(() {
      id = any;
    });
    Uri getPatientUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      getPatientUri =
          Uri.https(Constants.BASE_URL, '/api/patients/patientss/$id/');
    } else {
      getPatientUri =
          Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
    }
    Uri getImagesUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      getImagesUri =
          Uri.https(Constants.BASE_URL, '/api/patients/all/$id/get_images/');
    } else {
      getImagesUri =
          Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
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
    // if (picture==null) return;
    // String path = picture!.path;
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    var request = http.MultipartRequest("GET", getPatientUri);
    request.headers.addAll({"Authorization": "Token $token"});
    http.StreamedResponse response = await request.send();

    var decodedPatient = jsonDecode(patientRes.body);
    pictures = json.decode(imageRes.body);
    XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if (responseString != null && retrievedPicture != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ShowPatient(
                    token: token,
                    details: decodedPatient,
                    picture: retrievedPicture,
                    isFromAll: isFromAll,
                    is_superuser: is_superuser,
                  )));
    } else {
      const snackbar = SnackBar(
          content: Text(
        "No Match",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  //end of button

  Widget deletePatient() {
    //TO-DO: call Delete Patient Widget
    return Container();
  }
}
