import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';



import '../utils/constant.dart';


//import 'package:flutter_auth_roleperm/screens/userdetailsscreen.dart';
import '../models/patientsdata.dart';
class AddNewPatient extends StatefulWidget {
final token;


   const AddNewPatient({super.key, required this.token});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;      
  TextEditingController  firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  void initState() {
     token = widget.token;
    super.initState();
    // initCamera(widget.patients![0]);
  }

  // // ({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Add New Patient'),
      ),
       body: Container(
        decoration:BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
         child: ListView(
          children: <Widget>[
            addTextInfo(),
            SubmitButton(),
          
          ],
        ),
    ));
  }

  Widget addTextInfo(){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: <Widget>[
        SizedBox(height: 30.0),
        TextFormField(
          controller: firstNameController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'First Name',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        SizedBox(height: 30.0),
        TextFormField(
          controller: lastNameController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.person, color: Colors.white70),
            hintText: 'Last Name',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
          SizedBox(height: 30.0),
          TextFormField(
          controller: ageController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.numbers_rounded, color: Colors.white70),
            hintText: 'Age',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ]),

    );

  }

  Widget SubmitButton(){
  return Container(
     margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            PatientsData? data = await postPatient(token);
            print('info after login');
            if(data!=null)
              print(data.id);
            setState(() {});
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => Homepage(token: token)),
            //     (Route<dynamic> route) => false);
              
          },
        )


  );
}

Widget AddPhoto(){
  return Container();
}

 Future<PatientsData?> postPatient(token) async {
      var myProfileUri =  Uri.parse('${Constants.BASE_URL}/api/patients/patientss/');
      print('come to post data');
      print(token);
    final res = await http.post(myProfileUri,
    headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token '+ token,
      },
    body: {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "age":ageController.text,
}
    );

  var data = res.body;
  if (res.statusCode == 201) {
    String responseString = res.body;

     setState(() {
          
        });


      return patientFromJson(responseString);
    } else {
      print('nothing return');
      return null;
    }
  }

}
