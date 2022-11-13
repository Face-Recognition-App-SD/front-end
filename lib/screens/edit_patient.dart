import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rostro_app/screens/patient_list.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';

import '../utils/constant.dart';
import '../screens/delete.dart';

import 'package:camera/camera.dart';
import 'package:rostro_app/screens/get_patient_pictures.dart';

class editPatient extends StatefulWidget {
  final String token;
  final Map<String, dynamic> details;
  final XFile picture;

  // final String? id;
  const editPatient({
    super.key,
    required this.token,
    required this.details,
    required this.picture,
  });

  @override
  State<editPatient> createState() => _editPatient();
}

class _editPatient extends State<editPatient> {
  var bg = './assets/images/bg.jpeg';
  late Map<String, dynamic> details = widget.details;
  late String token = widget.token;
  late String id = widget.details['id'].toString();
  late XFile picture = widget.picture;
  late List<XFile?> pictures;

 // TextEditingController idController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController med_listController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
  TextEditingController date_of_birthController = TextEditingController();
  TextEditingController street_addressController = TextEditingController();
  TextEditingController city_addressController = TextEditingController();
  TextEditingController zipcode_addressController = TextEditingController();
  TextEditingController state_addressController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController emergency_contact_nameController =
      TextEditingController();
  TextEditingController emergency_phone_number = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Patient'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
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
            //    pic(),

                //  delete(id, token),
          //      addPhotos(),
                textData(),

                submitButton(context),
                 EditImageButton( context) 
              ],
            ),
          ),
        ));
  }

  Widget pic() {
    String picturePath = "${Constants.BASE_URL}${picture.path}";
    //String picturePath = picture.path;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(picturePath, fit: BoxFit.fill, width: 250),
          //Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
        ]);
  }

  delete(String id, String token) async {
    var rest = await deletePatient(id, token);
    print('inside delete');
    print(rest);
    setState(() {});
  }

  Widget submitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              PatientsData? data = await editPatientInfo();
print('datat inside $data');
               if (data != null) {
                 _showDialog(context, token);
               }

              //   setState(() {});
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => Homepage(token: token)),
                //     (Route<dynamic> route) => false);
              
            },),);
  }

 Widget EditImageButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            child: const Text('Update Images'),
            onPressed: () async {
              
             pictures = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetPatientPictures(token: token)));
             print ('chup hinh');
          print(pictures.length);
          print('co du lieu');
      editPatientInfo();

              //   setState(() {});
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => Homepage(token: token)),
                //     (Route<dynamic> route) => false);
              
            },),);
  }



  Future<PatientsData?> editPatientInfo() async {
    //var addPatientTextUri = Uri.https(Constants.BASE_URL,'/api/patients/patientss/');
   var addPatientTextUri = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/");
    final res = await http.patch(addPatientTextUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    }, body: {
      "first_name": firstnameController.text,
      "last_name": lastnameController.text,
      "age": ageController.text,
      "med_list": med_listController.text,
      "phone_number": phone_numberController.text,
      "date_of_birth": date_of_birthController.text,
    });


    if (res.statusCode < 300 && res.statusCode > 199) {
      String responseString = res.body;
      setState(() {});
      return patientFromJson(responseString);
    } else throw Exception('Failed to update patient.');
  }
  
  Future <HttpClientResponse?> updateImages() async{
     //   var data = json.decode(res.body);
    // print(data);
    // id = data['id'];
    //var addPatientPictures = Uri.https(Constants.BASE_URL,'/api/patients/patientss/$id/upload-image/');
    var addPatientPictures = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/upload-image/");
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

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
   print (responseString);
  
  }
  Widget textData() {
    firstnameController.text = details['first_name'];
    lastnameController.text = details['last_name'];
    ageController.text = details['age'].toString();
    //  med_listController.text = details['med_list'] ?? 'Not provided';
    //  phone_numberController.text = details['phone_number'] ?? 'Not provided';
    // date_of_birthController.text = details['date_of_birth'] ?? "0000-00-000";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20.0),

        Text(
          "\t Firstname:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: firstnameController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70, fontSize: 14),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),

        const SizedBox(height: 20.0),
        Text(
          "\t Lastname:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: lastnameController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70, fontSize: 14),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),

        const SizedBox(height: 20.0),
        Text(
          "\t Age:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),

        TextFormField(
          controller: ageController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70, fontSize: 13),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            // hintText: 'DepartID',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        // const SizedBox(height: 40.0),
//          const SizedBox(height: 20.0),
//         Text(
//           "\t Medical List:",
//           textAlign: TextAlign.left,
//           style: TextStyle(fontSize: 14, color: Colors.white),
//         ),

//         TextFormField(
//           controller: med_listController,
//           cursorColor: Colors.white,
//           style: TextStyle(color: Colors.white70, fontSize: 13),
//           decoration: const InputDecoration(
//             icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
//             // hintText: 'DepartID',
//             border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white70)),
//             hintStyle: TextStyle(color: Colors.white70),
//           ),
//         ),
      
//   const SizedBox(height: 20.0),
//         Text(
//           "\t Phone Number:",
//           textAlign: TextAlign.left,
//           style: TextStyle(fontSize: 14, color: Colors.white),
//         ),

//         TextFormField(
//           controller: phone_numberController,
//           cursorColor: Colors.white,
//           style: TextStyle(color: Colors.white70, fontSize: 13),
//           decoration: const InputDecoration(
//             icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
//             // hintText: 'DepartID',
//             border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white70)),
//             hintStyle: TextStyle(color: Colors.white70),
//           ),
//         ),
      

//  const SizedBox(height: 20.0),
//         Text(
//           "\t Date of Birth:",
//           textAlign: TextAlign.left,
//           style: TextStyle(fontSize: 14, color: Colors.white),
//         ),

//         TextFormField(
//           controller: date_of_birthController,
//           cursorColor: Colors.white,
//           style: TextStyle(color: Colors.white70, fontSize: 13),
//           decoration: const InputDecoration(
//             icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
//             // hintText: 'DepartID',
//             border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white70)),
//             hintStyle: TextStyle(color: Colors.white70),
//           ),
//         ),
      

      ],
    );
  }

  Widget addPhotos() {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 199, 201, 224),
            shape: BoxShape.rectangle,
            //borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(30, 0, 0, 0),
                decoration: TextDecoration.underline,
              ),
            ),
            child: const Text('Edit Photo'),
            onPressed: () async {
              picture = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetPatientPictures(token: token)));
            },
          )),
    );
  }

  Widget? _showDialog(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message!!"),
          content:
              const Text("Patient informatinon has been edited successfully!"),
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
}
