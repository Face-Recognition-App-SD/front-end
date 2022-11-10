import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:rostro_app/screens/login_page.dart';

import '../utils/constant.dart';

import 'dart:io';
import './verifyEmail.dart';
//import 'loggedinpage.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmail();
}

class _VerifyEmail extends State<VerifyEmail> {
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
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
            SubmitButtonSection(context),
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

  //TextEditingController emailVerify = TextEditingController();
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
            style: TextStyle(color: Colors.white70, fontSize: 13),
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

  Container SubmitButtonSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            String email = widget.email;
            String key = keyController.text;
            var data = await fetchVerify(
              email,
              keyController.text,
            );

            print('info after login');
            

            if (data != null) {
              var result = data.body.toString();
              result = result.substring(10, data.body.length - 1);
              print (result);
              if (result == 'true') ShowDialogSucc(context);

              //     (Route<dynamic> route) => false);
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
                        color: Color.fromARGB(236, 9, 96, 168),
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
    var response = await http.post(
        //  Uri.https('api.rostro-authentication.com',/api/user/email/verify/'),
        Uri.parse('${Constants.BASE_URL}/api/user/email/verify/'),
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
}

Widget? ShowDialogSucc(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Message!"),
        content: new Text("Your account has been verified."),
        actions: <Widget>[
          new TextButton(
            child: new Text("Go to Login"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      );
    },
  );
}
