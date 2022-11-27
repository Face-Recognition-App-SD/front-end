import 'dart:io';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';
import 'package:rostro_app/screens/login_page.dart';
import '../utils/constant.dart';
import 'package:http/http.dart' as http;

class PasswordChange extends StatefulWidget {
  final String token;
  const PasswordChange({super.key, required this.token});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  late String token = widget.token;

  var bg = './assets/images/bg6.gif';
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
            controller: oldPasswordController,
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
            controller: newPasswordController,
            cursorColor: Colors.white70,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Please enter your new password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: confirmNewPasswordController,
            cursorColor: Colors.white70,
            style: const TextStyle(color: Colors.white70),
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
      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
      child: Image.asset(
        './assets/images/logo.jpeg',
        height: 170,
        width: 150,
        fit: BoxFit.fitWidth,
      ),
    );
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
    Uri myProfileUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myProfileUri = Uri.https(Constants.BASE_URL, '/api/user/changepwd/');
    } else {
      myProfileUri = Uri.parse("${Constants.BASE_URL}/api/user/changepwd/");
    }

    final response = await http.patch(
      myProfileUri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: {
        'old_password': oldPasswordController.text,
        'new_password': newPasswordController.text,
        'new_password_confirm': confirmNewPasswordController.text,
      },
    );
    if (response.statusCode == 200) {
      const snackbar = SnackBar(
        content: Text(
          "successfully changed password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
      );
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
