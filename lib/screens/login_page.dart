import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import './homepage.dart';
import './regisnew.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;

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
            signUpButtonSection(),
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
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: <Widget>[
        TextFormField(
          controller: emailController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            icon: Icon(Icons.email, color: Colors.white70),
            hintText: 'Email',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        SizedBox(height: 30.0),
        TextFormField(
          controller: passwordController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white70),
          decoration: InputDecoration(
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
              String password =passwordController.text;
             UserLogin? data = await fetchDataLogin(email, password);

                    setState(() {
                   
                    });
           Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Homepage()),
            (Route<dynamic> route) => false);
          
           
        },
      )

     //end of button
    );
  }

  Container signUpButtonSection() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: Text('Sign Up'),
        // color: Colors.blueAccent,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisNewFirst()),
          ), //button connects to register page
        },
      ),
    );
  }




Future<UserLogin?> fetchDataLogin(String email, String password) async {
       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       var response = await http.post(
    //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
       Uri.http('192.168.1.80:8000', 'api/user/token/'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: {
        "email": email,
        "password": password,
     
      });
      var jsonResponse = null;
  var data = response.body;
  print(data);
  if (response.statusCode == 201) {
    String responseString = response.body;

     setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString('token', jsonResponse['token']);
        
    return albumFromJson(responseString);
  } else {
    return null;
  }
}


  // signIn(String email, pass) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map data = {
  //     'email': email,
  //     'password': pass,
  //   };
  //   var jsonResponse = null;
  //   var response = await http.post(
  //     Uri.http('192.168.1.80:8000', 'api/user/token/'),
  //     headers: {
  //       HttpHeaders.acceptHeader: 'application/json',
  //     },
  //     body: {data},
  //   );
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
       
  //     }
  //     else{
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print(response.body);

  //     }
  //   }
  // }
}
