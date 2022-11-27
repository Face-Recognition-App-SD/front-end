import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rostro_app/screens/Home.dart';

import 'package:rostro_app/screens/login_page.dart';

import '../utils/constant.dart';
import '../admins/am_home_page.dart';

import 'dart:io';

class AdminVerifyEmail extends StatefulWidget {
  final String email;
  final String token;
  const AdminVerifyEmail({super.key, required this.email, required this.token});

  @override
  State<AdminVerifyEmail> createState() => _AdminVerifyEmail();
}

class _AdminVerifyEmail extends State<AdminVerifyEmail> {
  var bg = './assets/images/bg.jpeg';
  late String email;
  String token ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
    token = widget.token;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
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
            submitButtonSection(context),
          ],
        ),
      ),
    );
  } //build

  Container headerSection() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Image.asset(
          './assets/images/logo.jpeg',
          height: 100,
          width: 90,
          fit: BoxFit.scaleDown,
        ));
  }

  TextEditingController keyController = TextEditingController();

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Text(
            "Email to verify: $email",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: keyController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: 'Key',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ]),
      ),
    );
  }

  Container submitButtonSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
          child: const Text('Submit'),
          onPressed: () async {
            String email = widget.email;
            String key = keyController.text;
            var data = await fetchVerify(
              email,
              keyController.text,
            );
            if (data != null) {
              var result = data.body.toString();
              result = result.substring(10, data.body.length - 1);
              if (result == 'true') ShowDialogSucc(context);
            } else {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Alert Dialog Box"),
                  content: const Text(
                      "The verify code is not correct. Please check your mailbox"),
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
          }

          //end of button
          ),
    );
  }

  Future<http.Response> fetchVerify(email, key) async {
    Uri myfetchUri = Uri();
    if(Constants.BASE_URL == "api.rostro-authentication.com"){
      myfetchUri = Uri.https(Constants.BASE_URL, '/api/user/email/verify/');
    }
    else{
      myfetchUri = Uri.parse('${Constants.BASE_URL}/api/user/email/verify/');
    }
    var response = await http.post(
        myfetchUri,
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: {
          "email": email,
          "key": key,
        });

    if (response.statusCode > 200 && response.statusCode < 300) {
      return response;
    } else {
      throw "Sorry! You're email can't verify";
    }
  }


Widget? ShowDialogSucc(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Message!"),
        content: const Text("Your account has been verified."),
        actions: <Widget>[
          TextButton(
            child: const Text("Back to HomePage"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  AdminHomePage(token: token,)),
              );
            },
          ),
        ],
      );
    },
  );
}
}