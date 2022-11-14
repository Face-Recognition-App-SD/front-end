import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';
import 'package:rostro_app/screens/get_patient_pictures.dart';
import 'package:rostro_app/screens/patient_list.dart';
import '../utils/constant.dart';
import 'package:camera/camera.dart';

class AddNewPatient extends StatefulWidget {
  final String token;

  const AddNewPatient({super.key, required this.token});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;

  //late Map<String, dynamic> pictures;
  late int id;
  XFile? picture;
  late List<XFile?> pictures;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController med_listController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
 // TextEditingController date_of_birthController = TextEditingController();
  @override
  void initState() {
    token = widget.token;
    super.initState();
    // initCamera(widget.patients![0]);
  }

  // // ({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Patient'),
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
              addTextInfo(),
              addPhotos(),
              submitButton(context),
            ],
          ),
        ));
  }

  Widget addTextInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: <Widget>[
        const SizedBox(height: 20.0),
        TextFormField(
          controller: firstNameController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'First Name',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: lastNameController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70),
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'Last Name',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: ageController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70),
          decoration: const InputDecoration(
            icon: Icon(Icons.numbers_rounded, color: Colors.white70),
            hintText: 'Age',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),

   const SizedBox(height: 20.0),
    
        TextFormField(
          controller: med_listController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70, fontSize: 13),
          decoration: const InputDecoration(
            icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
             hintText: 'Medical List',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      
  const SizedBox(height: 20.0),
    

        TextFormField(
          controller: phone_numberController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70, fontSize: 13),
          decoration: const InputDecoration(
            icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
            hintText: 'Phone Number',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      

 const SizedBox(height: 20.0),
 

        // TextFormField(
        //   controller: date_of_birthController,
        //   cursorColor: Colors.white,
        //   style: TextStyle(color: Colors.white70, fontSize: 13),
        //   decoration: const InputDecoration(
        //     icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
        //      hintText: 'Date of birth yyyy-mm-dd',
        //     border: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.white70)),
        //     hintStyle: TextStyle(color: Colors.white70),
        //   ),
        // ),

      ]),
    );
  }

  Widget submitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Submit'),
          onPressed: () async {
            PatientsData? data = await postPatient();
            if (data != null){
              _showDialog(context, token);

            setState(() {});
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => Homepage(token: token)),
            //     (Route<dynamic> route) => false);
          }
          }
        ));
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
            child: const Text('Add Photo'),
            onPressed: () async {
             pictures = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetPatientPictures(token: token)));
            },
          )),
    );
  }

  Future<PatientsData?> postPatient() async {
  var addPatientTextUri = Uri.https(Constants.BASE_URL,'/api/patients/patientss/');
   // var addPatientTextUri = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/");
  showDialog(
      context: context,
      builder: (context){
        return const Center(child: CircularProgressIndicator(),);
      }
  );
    final res = await http.post(addPatientTextUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    }, body: {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "age": ageController.text,
      "med_list": med_listController.text,
      "phone_number": phone_numberController.text,
    });

    var data = json.decode(res.body);
    print(data);
    id = data['id'];
    var addPatientPictures = Uri.https(Constants.BASE_URL,'/api/patients/patientss/$id/upload-image/');
    //var addPatientPictures = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/upload-image/");
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
  Navigator.of(context).pop();
    if (res.statusCode < 300 && res.statusCode > 199) {
      String responseString = res.body;
      setState(() {});
      return patientFromJson(responseString);
    } else {
      return null;
    }
  }
}
Widget? _showDialog(BuildContext context, String token) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Message!!"),
        content: const Text("New patient has been created successfully!"),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
               Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PatientList(token: token,)),
          );
            },
          ),
        ],
      );
    },
  );
}
