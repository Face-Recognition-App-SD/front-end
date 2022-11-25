import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:rostro_app/screens/resetpwd2.dart';
import 'package:rostro_app/screens/verifyEmail.dart';
import '../models/userlogin.dart';
import '../utils/Glassmorphism.dart';
import 'package:gap/gap.dart';

import '../utils/constant.dart';
import 'package:http/http.dart' as http;

class resetPassword extends StatefulWidget {
  const resetPassword({
    super.key,
  });

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  var bg = './assets/images/bg6.gif';
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // String email = emailController.text;
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
            reset(),
            Gap(30),
            confirmButton(),
          ],
        ),
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

  Container reset() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white70,
                  style: const TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: Colors.white70),
                    hintText: 'Enter your account Email Address',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container confirmButton() {
    return Container(
      margin: const EdgeInsets.only(left: 55, right: 55),
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Glassmorphism(
        blur: 20,
        opacity: 0.1,
        radius: 50.0,
        child: TextButton(
          child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: const Text('Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                  ))),
          onPressed: () async {
            String email = emailController.text;
            var data = await VerifyEmail(email);
            print(data);
            if (email.isNotEmpty) {
              JumpToNextPage(context);
            } else {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Error Message'),
                  content: const Text('Please input an Email Address!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: const Color.fromARGB(236, 9, 96, 168),
                        padding: const EdgeInsets.all(14),
                        child: const Text("OK"),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Future<http.Response> pwdresetemail(email) async {
  //   Uri myResetUri = Uri();
  //   if (Constants.BASE_URL == "api.rostro-authentication.com") {
  //     myResetUri =
  //         Uri.https(Constants.BASE_URL, '/api/user/send_resetpwdemail/');
  //   } else {
  //     myResetUri =
  //         Uri.parse("${Constants.BASE_URL}/api/user/send_resetpwdemail/");
  //   }

  //   final response = await http.post(
  //     myResetUri,
  //     headers: {HttpHeaders.acceptHeader: 'applciation/json'},
  //     body: {
  //       'email': emailController.text,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return response;
  //   } else {
  //     throw "No User Found!";
  //   }
  // }

  Widget? JumpToNextPage(BuildContext context) {
    String email = emailController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message!"),
          content: const Text("Please continue to reset your password!"),
          actions: <Widget>[
            TextButton(
              child: const Text("Next"),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EnterResetKey(email: email),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<http.Response> VerifyEmail(String email) async {
    Uri tokenUrl = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      tokenUrl = Uri.https(Constants.BASE_URL, '/api/user/send_resetpwdemail/');
    } else {
      tokenUrl =
          Uri.parse('${Constants.BASE_URL}/api/user/send_resetpwdemail/');
    }
    var response = await http.post(
      tokenUrl,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: {
        "email": email,
      },
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      throw "nope";
    }
  }
}
