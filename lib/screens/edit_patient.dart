import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/patient_list.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';

import '../utils/constant.dart';
import '../screens/delete.dart';

import 'package:camera/camera.dart';
import 'package:rostro_app/screens/get_patient_pictures.dart';

class EditPatient extends StatefulWidget {
  final String token;
  final Map<String, dynamic> details;

  const EditPatient({
    super.key,
    required this.token,
    required this.details,
  });

  @override
  State<EditPatient> createState() => ExtendEditPatient();
}

class ExtendEditPatient extends State<EditPatient> {
  var bg = './assets/images/bg.jpeg';
  late Map<String, dynamic> details = widget.details;
  late String token = widget.token;
  late String id = widget.details['id'].toString();
  List<XFile?> pictures = [];

 // TextEditingController idController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController medListController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityAddressController = TextEditingController();
  TextEditingController zipcodeAddressController = TextEditingController();
  TextEditingController stateAddressController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController emergencyContactNameController =
      TextEditingController();
  TextEditingController emergencyPhoneNumber = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Patient'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  delete(id, token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PatientList(
                              token: token,
                            )),
                  );
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg),
              fit: BoxFit.cover,
            ),
          ), //background image
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                const SizedBox(height: 10.0),
                Text(
                  "\t\t ID: $id",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                //  delete(id, token),
          //      addPhotos(),
                textData(),
                getImages( context),
                submitButton(context),
              ],
            ),
          ),
        ));
  }

  delete(String id, String token) async {
    var rest = await deletePatient(id, token);
    setState(() {});
  }


 Widget getImages(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            child: const Text('Update Images'),
            onPressed: () async {
              
             pictures = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetPatientPictures(token: token)));
            },),);
  }

  Future<bool> editPatientInfo() async {
    Uri addPatientTextUri = Uri();
    if(Constants.BASE_URL == "api.rostro-authentication.com"){
      addPatientTextUri = Uri.https(Constants.BASE_URL,'/api/patients/patientss/$id/');
    }
    else{
      addPatientTextUri = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/");
    }
    bool flag = false;
   if(firstnameController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'first_name', firstnameController.text);
     flag = true;
   }
   if(lastnameController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'last_name', lastnameController.text);
     flag = true;
   }
   if(ageController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'age', ageController.text);
     flag = true;
   }
   if(medListController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'med_list', medListController.text);
     flag = true;
   }
   if(phoneNumberController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'phone_number', phoneNumberController.text);
     flag = true;
   }
   if(dobController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'date_of_birth', dobController.text);
     flag = true;
   }
   if(streetAddressController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'street_address', streetAddressController.text);
     flag = true;
   }
   if(cityAddressController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'city_address', cityAddressController.text);
     flag = true;
   }
   if(zipcodeAddressController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'zipcode_address', zipcodeAddressController.text);
     flag = true;
   }
   if(stateAddressController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'state_address', stateAddressController.text);
     flag = true;
   }
   if(linkController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'link', linkController.text);
     flag = true;
   }
   if(emergencyContactNameController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'emergency_contact_name', emergencyContactNameController.text);
     flag = true;
   }
   if(emergencyPhoneNumber.text.isNotEmpty){
     editPatient(addPatientTextUri, 'emergency_phone_number', emergencyPhoneNumber.text);
     flag = true;
   }
   if(genderController.text.isNotEmpty){
     editPatient(addPatientTextUri, 'gender', genderController.text);
     flag = true;
   }
   return flag;
  }
  Future<PatientsData?> editPatient(addPatientTextUri, key, val) async {
    final res = await http.patch(addPatientTextUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    }, body: {
      key: val,
    });
  }

  Future<bool> updateImages() async{
    if (pictures.isNotEmpty) {
      Uri addPatientPictures = Uri();
      if(Constants.BASE_URL == "api.rostro-authentication.com"){
        addPatientPictures = Uri.https(Constants.BASE_URL, '/api/patients/patientss/$id/upload-image/');
      }
      else{
        addPatientPictures = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/upload-image/");
      }
      var request = http.MultipartRequest("POST", addPatientPictures);
      request.headers.addAll({"Authorization": "Token $token"});
      request.fields['id'] = id.toString();
      var image1 = await http.MultipartFile.fromPath("image_lists", pictures[0]!.path);
      request.files.add(image1);
      var image2 = await http.MultipartFile.fromPath("image_lists", pictures[1]!.path);
      request.files.add(image2);
      var image3 = await http.MultipartFile.fromPath("image_lists", pictures[2]!.path);
      request.files.add(image3);
      
      http.StreamedResponse response = await request.send();

      if(response.statusCode > 199 && response.statusCode < 300){
        return true;
      }
      //var responseData = await response.stream.toBytes();
      //var responseString = String.fromCharCodes(responseData);
      // print (responseString);
    }
    return false;
  }
  Widget textData() {
    firstnameController.text = details['first_name'];
    lastnameController.text = details['last_name'];
    ageController.text = details['age'].toString();
    medListController.text = details['med_list'] ?? 'Not provided';
    phoneNumberController.text = details['phone_number'] ?? 'Not provided';
    // date_of_birthController.text = details['date_of_birth'] ?? "0000-00-000";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20.0),

        const Text(
          "\t Firstname:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: firstnameController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),

        const SizedBox(height: 20.0),
        const Text(
          "\t Lastname:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: lastnameController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),

        const SizedBox(height: 20.0),
        const Text(
          "\t Age:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: ageController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
       
         const SizedBox(height: 20.0),
        const Text(
          "\t Medical List:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: medListController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
          decoration: const InputDecoration(
            icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      
  const SizedBox(height: 20.0),
        const Text(
          "\t Phone Number:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: phoneNumberController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
          decoration: const InputDecoration(
            icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }


  Widget? _showDialog(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message!!"),
          content:
              const Text("Patient information has been edited successfully!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PatientList(
                            token: token,
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }
  Widget submitButton(BuildContext context) {
    var resPics = false;
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: const Text('Submit'),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context){
                return const Center(child: CircularProgressIndicator(),);
              }
          );
          var resText = await editPatientInfo();
          if (pictures.isNotEmpty) {
           resPics = await updateImages();
          }
          Navigator.of(context).pop();
          if(resText || resPics){
            _showDialog(context, token);
          }
        },),);
  }
}
