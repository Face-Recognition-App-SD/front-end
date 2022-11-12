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
  final String? token;
  const pwdchange({super.key, required this.token});

  @override
  State<pwdchange> createState() => _pwdchangeState();
}

class _pwdchangeState extends State<pwdchange> {
  @override
  TextEditingController opwdController = TextEditingController();
  TextEditingController npwdController = TextEditingController();
  TextEditingController cnpwdController = TextEditingController();

  void initState() {
    String? token = widget.token;
    super.initState();
  }

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
            oldpwd(),
            confirmButton(),
          ],
        ),
      ),
    );
  }

  Container oldpwd() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: opwdController,
            cursorColor: Colors.white70,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Please enter your old password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: npwdController,
            cursorColor: Colors.white70,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
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
            decoration: InputDecoration(
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
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: Text('Submit'),
        onPressed: () async {
          String oldpass = opwdController.text;
          String newpassword = npwdController.text;
          String cnewpass = cnpwdController.text;
          UserLogin? user = await pwdchg(oldpass, newpassword, cnewpass);
          setState(() {});
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => false);
        },
      ),
    );
  }

  Future<UserLogin?> pwdchg(
      String oldpass, String newpassword, String confirmpassword) async {
    String? token = widget.token;
    final response =
        await http.patch(Uri.parse("${Constants.BASE_URL}/api/user/changepwd/"),
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Token $token',
            },
            body: jsonEncode({
              'old_password': oldpass,
              'new_password': newpassword,
              'new_password_confirm': confirmpassword,
            }));
    if (response.statusCode == 200) {
      String responseString = response.body;

      setState(() {});

      return albumFromJson(responseString);
    } else {
      return null;
    }
  }
}
