import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rostro_app/screens/login_page.dart';

import '../utils/constant.dart';
import './homepage.dart';
import './login_page.dart';
import 'dart:io';
//import 'loggedinpage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;
  late String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
            headerSection(),
            textSection(),
            SubmitButtonSection(),
            //    signUpButtonSection(),
          ],
        ),
      ),
    );
  } //build

  Container headerSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Image.asset(
          './assets/images/logo.jpeg',
          height: 100,
          width: 90,
          fit: BoxFit.scaleDown,
        ));
    //background im
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController department_idController = TextEditingController();

  final List<String> gender = [
    'Male',
    'Female',
    'Transgender',
    'Non-binary'
  ];

  final List<String> roles = ['Doctor', 'Nurse', 'Physical Therapist'];
  String? selectedValueforGender;
  String? selectedValueforRoles;

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: 'Email',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: first_nameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'First name',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: last_nameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Last name',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.local_hospital, color: Colors.white70),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text(
                    '   Roles',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  items: roles
                      .map((roles) => DropdownMenuItem<String>(
                            value: roles,
                            child: Text(
                              roles,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValueforRoles,
                  onChanged: (value) {
                    setState(() {
                      selectedValueforRoles = value as String;
                    });
                  },
                  buttonHeight: 30,
                  buttonWidth: 300,
                  itemHeight: 30,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color.fromARGB(236, 9, 96, 168),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: department_idController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Department ID',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.white70),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text(
                    '   Gender',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  items: gender
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValueforGender,
                  onChanged: (value) {
                    setState(() {
                      selectedValueforGender = value as String;
                    });
                  },
                  buttonHeight: 30,
                  buttonWidth: 300,
                  itemHeight: 30,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(236, 9, 96, 168),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
        ]),
      ),
    );
  }

  Container SubmitButtonSection() {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;
            UserLogin? data = await fetchDataSignUp(
                email,
                password,
                first_nameController.text,
                last_nameController.text,
                selectedValueforRoles ?? "Nurse",
                department_idController.text,
                selectedValueforGender ?? "Male");
            print('info after login');
            print(token);
            setState(() {});
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
          },
        )

        //end of button
        );
  }

  Future<UserLogin?> fetchDataSignUp(
      String email,
      String password,
      String first_name,
      String last_name,
      String role,
      String dep,
      String gender) async {
    var response = await http.post(
        //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
        Uri.parse('${Constants.BASE_URL}/api/user/create/'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: {
          "email": email,
          "password": password,
          "first_name": first_name,
          "last_name": last_name,
          "role": role,
          "department_id": dep,
          "gender": gender,
        });
    var jsonResponse = null;
    var data = response.body;
    token = data.substring(10, data.length - 2);
    if (response.statusCode == 201) {
      String responseString = response.body;

      setState(() {
        _isLoading = false;
      });

      return albumFromJson(responseString);
    } else {
      return null;
    }
  }
}
