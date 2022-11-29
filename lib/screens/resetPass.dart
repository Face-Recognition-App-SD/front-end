import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:rostro_app/screens/firstpage.dart';
import 'package:rostro_app/screens/verifyEmail.dart';
import '../models/userlogin.dart';
import '../utils/Glassmorphism.dart';
import 'package:gap/gap.dart';

import '../utils/constant.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({
    super.key,
  });

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  var bg = 'assets/images/bg1.gif';
  TextEditingController emailController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: textSection1(),
                  ),
                  confirmButton(),
                ],
              ),
            ),
            textSection2(),
            SubmitButton(),
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

  Container textSection1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      margin: const EdgeInsets.only(right: 5),
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
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: Colors.black),
                    hintText: 'Enter your Email',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container textSection2() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: keyController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    icon: Icon(Icons.numbers, color: Colors.black),
                    hintText: 'Enter your Key',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: passwordController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields, color: Colors.black),
                    hintText: 'Enter your new password',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
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
      margin: const EdgeInsets.only(right: 5, top: 8),
      // padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
            child: const Text(
              'Verify',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
            ),
          ),
          onPressed: () async {
            String email = emailController.text;
            var data = await VerifyEmail(email);
            print(data);
            if (email.isNotEmpty) {
              VerifyAction(context);
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

  Container SubmitButton() {
    return Container(
      margin: const EdgeInsets.only(left: 55, right: 55, top: 20),
      child: Glassmorphism(
        blur: 20,
        opacity: 0.1,
        radius: 50.0,
        child: TextButton(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.black, fontSize: 13.0),
            ),
          ),
          onPressed: () async {
            String email = emailController.text;
            String key = keyController.text;
            String password = passwordController.text;
            var data = await passwordReset();
            setState(() {});
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));
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

  Widget? VerifyAction(BuildContext context) {
    String email = emailController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Action Required!"),
          content: const Text(
              "Please check your Email Address to retrieve your key\n"),
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
      //   throw "nope";
      const snackbar = SnackBar(
        content: Text(
          'Invalid Email Address',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      throw "nope";
    }
  }

  Future<UserLogin?> passwordReset() async {
    Uri resetUrl = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      resetUrl = Uri.https(Constants.BASE_URL, '/api/user/resetpwd/');
    } else {
      resetUrl = Uri.parse('${Constants.BASE_URL}/api/user/resetpwd/');
    }
    var response = await http.patch(
      resetUrl,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: {
        "email": emailController.text,
        "key": keyController.text,
        "password": passwordController.text
      },
    );
    if (response.statusCode == 200) {
      const snackbar = SnackBar(
        content: Text(
          "Password reset successed!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
      );
    } else {
      const snackbar = SnackBar(
          content: Text(
        "password reset failed",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
