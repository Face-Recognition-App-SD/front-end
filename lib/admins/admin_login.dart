import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import './admin_home.dart';

import 'dart:io';
//import 'loggedinpage.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;
  late String token;
  late String? firstName;
  late String? lastName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            loginButtonSection(),
           
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
          height: 170,
          width: 150,
          fit: BoxFit.fitWidth,
        ));
    //background im
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: <Widget>[
        TextFormField(
          controller: emailController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: const InputDecoration(
            icon: Icon(Icons.email, color: Colors.white70),
            hintText: 'Email',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
       const SizedBox(height: 30.0),
        TextFormField(
          controller: passwordController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white70),
          decoration: const InputDecoration(
            icon: Icon(Icons.lock, color: Colors.white70),
            hintText: 'Password',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ]),
    );
  }

  Container loginButtonSection() {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: () async {
           
            String email = emailController.text;
            String password = passwordController.text;
            UserLogin? data = await fetchDataLogin(email, password);
            firstName = data!.first_name;
            lastName = data!.last_name;
            print('info after login');
                print(token);
            setState(() {});
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => AdminHome(token:token,firstname: firstName, lastname: lastName)),
                (Route<dynamic> route) => false);
              
          },
        )

        //end of button
        );
  }



Future<UserLogin?> fetchDataLogin(String email, String password) async {
   var response = await http.post(
    //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
     Uri.parse('${Constants.BASE_URL}/api/user/token/'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: {
        "email": email,
        "password": password,

      });
      var jsonResponse = null;
  var data = response.body;
  token = data.substring(10, data.length-2);
  print(response.statusCode);
  if (response.statusCode > 199 && response.statusCode < 301 ) {
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