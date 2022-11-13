import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';
import 'package:rostro_app/screens/login_page.dart';
import '../utils/constant.dart';
import 'package:http/http.dart' as http;

class pwdchange extends StatefulWidget {
  final String token;
  const pwdchange({super.key, required this.token});

  @override
  State<pwdchange> createState() => _pwdchangeState();
}

class _pwdchangeState extends State<pwdchange> {
  @override
  TextEditingController opwdController = TextEditingController();
  TextEditingController npwdController = TextEditingController();
  TextEditingController cnpwdController = TextEditingController();

  late String token = widget.token;

  var bg = './assets/images/bg.jpeg';
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            headerSection(),
            pwd(),
            confirmButton(),
          ],
        ),
      ),
    );
  }

  Container pwd() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: opwdController,
            cursorColor: Colors.white70,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Please enter your old password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: npwdController,
            cursorColor: Colors.white70,
            style: TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Please enter your new password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: cnpwdController,
            cursorColor: Colors.white70,
            style: TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Please confirm your new password',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

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

  Container confirmButton() {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: const Text('Submit'),
        onPressed: () async {
          await pwdchg();
          setState(() {});
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          );
        },
      ),
    );
  }

  Future<UserLogin?> pwdchg() async {
    final response = await http.patch(
        Uri.parse("${Constants.BASE_URL}/api/user/changepwd/"),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Token $token',
        },
        body: {
          'old_password': opwdController.text,
          'new_password': npwdController.text,
          'new_password_confirm': cnpwdController.text,
        });
    if (response.statusCode == 200) {
      const snackbar = SnackBar(
          content: Text(
        "successfully changed password",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      const snackbar = SnackBar(
          content: Text(
        "password change failed",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    /*
    setState(() {});
    if (response.statusCode == 200) {
      String responseString = response.body;
      print(response.body);
      setState(() {});

      return albumFromJson(responseString);
    } else {
      return null;
    }
    */
  }
}
