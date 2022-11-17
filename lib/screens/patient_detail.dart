import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/show_patient.dart';
import '../utils/constant.dart';
import './camera.dart';

class PatientDetail extends StatefulWidget {
  final String token;
  final String id; 
  const PatientDetail({super.key, required this.token, required this.id});

  @override
  State<PatientDetail> createState() => _PatientDetail();
}

class _PatientDetail extends State<PatientDetail> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  late Map<String, dynamic> pictures;
  late String id;
  XFile? picture;
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
        // child: ListView(
        //   children: <Widget>[
           
        //     getPatientDetail(id),
        //   ],
        // ),
      ),
    );
  }
 
  void getPatientDetail(String any) 
    
  //   return Container(
  //       margin: const EdgeInsets.only(top: 50.0),
  //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //       child: ElevatedButton(
  //         child: const Text('Take Picture of Patient'),
  //         onPressed: () 
  async {
            setState(() {
                  id = any;
            });
      
          
            print('id $id');
             print('token $token');
            
            //var getPatientUri =  Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/');
            var getPatientUri =  Uri.https(Constants.BASE_URL,'/api/patients/patientss/$id/');
          //  var getImagesUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/get_images/');
            var getImagesUri = Uri.https(Constants.BASE_URL,'/api/patients/all/$id/get_images/');
          //  var faceCompareUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/$id/faceverify/');
            // picture = await availableCameras().then((value) => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => Camera(token: token, cameras: value))));

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
            //request.fields['id'] = id.toString();
            // var image = await http.MultipartFile.fromPath("image", path);
            // request.files.add(image);
            http.StreamedResponse response = await request.send();

            var decodedPatient = jsonDecode(patientRes.body);
            pictures = json.decode(imageRes.body);
            XFile retrievedPicture = XFile(pictures['image_lists'][0]['image']);
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            print(responseString);
            if(responseString !=null && retrievedPicture!=null){
                    print('can go insdide resp');

              Navigator.push(context, MaterialPageRoute(builder: (_) => ShowPatient(token: token,  details: decodedPatient, picture: retrievedPicture)));
            }
            else{
              const snackbar = SnackBar(content: Text("No Match", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }

        
  }
      //end of button
    
  

  Widget deletePatient(){
    //TO-DO: call Delete Patient Widget
    return Container();
  }
}