import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rostro_app/models/userlogin.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import './homepage.dart';
import './regisnew.dart';
import 'dart:io';

import 'Treg.dart';
//import 'loggedinpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;
  late String token;
  bool _passwordVisible = false;

  // @override
  // void initState() {

  // }

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
    print("HHHHHHHHH");
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Image.asset(
          './assets/images/logo.jpeg',
          height: 170,
          width: 150,
          fit: BoxFit.fitWidth,
        ));
    //background im
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Welcome!',
              style: GoogleFonts.inter(fontSize: 17, color: Colors.white70)),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Login to your account',
            style: GoogleFonts.inter(
                fontSize: 23,
                color: Colors.white70,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
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
            keyboardType: TextInputType.text,
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: !_passwordVisible,
            style: const TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              hintText: 'Password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              icon: Icon(Icons.lock, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container loginButtonSection() {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          child: Text('Login'),
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;
            UserLogin? data = await fetchDataLogin(email, password);
            print('info after login');
            var tokenReturn = token.substring(0, 8);
            //  print(tokenReturn);
            if (tokenReturn == "d_errors") {
              print(tokenReturn);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    //    title: const Text("Message!!"),
                    content: const Text(
                      "The combination of email and password is not correct",
                    ),
                  );
                },
              );
            } else {
              //  setState(() {});
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Homepage(token: token)),
                  (Route<dynamic> route) => false);
            }
          },
        )

        //end of button
        );
  }

  Row signUpButtonSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Do not have an account?'),
        TextButton(
          child: const Text(
            'Sign up!',
            style: TextStyle(
              fontSize: 15,
            ),
          ),

          // color: Colors.blueAccent,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TRegister()),
            ), //button connects to register page
          },
        ),
      ],
    );
  }

  Future<UserLogin?> fetchDataLogin(String email, String password) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    Uri tokenUrl = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      tokenUrl = Uri.https(Constants.BASE_URL, '/api/user/token/');
    } else {
      tokenUrl = Uri.parse('${Constants.BASE_URL}/api/user/token/');
    }
    var response = await http.post(tokenUrl, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    }, body: {
      "email": email,
      "password": password,
    });

    var data = response.body;
    token = data.substring(10, data.length - 2);
    Navigator.of(context).pop();
    if (response.statusCode == 201) {
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
