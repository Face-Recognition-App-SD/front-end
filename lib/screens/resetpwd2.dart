import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../utils/constant.dart';

class EnterResetKey extends StatefulWidget {
  final String? email;
  const EnterResetKey({
    super.key,
    this.email,
  });

  @override
  State<EnterResetKey> createState() => _EnterResetKeyState();
}

class _EnterResetKeyState extends State<EnterResetKey> {
  @override
  void initState() {
    var email = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bg = './assets/images/bg6.gif';
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
            keybox(),
          ],
        ),
      ),
    );
  }

  TextEditingController keyController = TextEditingController();

  Widget keybox() {
    String? email = widget.email;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            "Changing Password for $email",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: keyController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.numbers, color: Colors.white70),
                    hintText: 'Key',
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

  Container headerSection() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Image.asset(
          './assets/images/logo.jpeg',
          height: 170,
          width: 150,
          fit: BoxFit.fitWidth,
        ));
  }

  Future<http.Response> keyVerify() async {
    Uri myKeyVerify = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myKeyVerify = Uri.https(Constants.BASE_URL, '/api/user/email/verify/');
    } else {
      myKeyVerify = Uri.parse('${Constants.BASE_URL}/api/user/email/verify/');
    }
    var response = await http.post()
  }
}
