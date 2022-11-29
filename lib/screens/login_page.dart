import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rostro_app/models/userlogin.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rostro_app/screens/userPictureUpload.dart';
import 'package:rostro_app/screens/resetPass.dart';
import '../utils/Glassmorphism.dart';
import '../utils/constant.dart';
import './homepage.dart';
import 'dart:io';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../screens/resetPass.dart';

import 'Register.dart';

//import 'loggedinpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // var bg = './assets/images/bg2.jpeg';
  var bg = './assets/images/bg1.gif';
  bool _isLoading = false;
  late String token;
  bool _passwordVisible = false;
  late Map<String, dynamic> pictures;

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
            pwdrst(),
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
          height: 170,
          width: 150,
          fit: BoxFit.fitWidth,
        ));
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
          GlassText('Welcome!',
              style: GoogleFonts.inter(fontSize: 45, color: Colors.white70)),
          const SizedBox(
            height: 8,
          ),
          GlassText(
            'Login to your account',
            style: GoogleFonts.inter(
                fontSize: 23,
                color: Colors.white70,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              // decoration: BoxDecoration(
              // color: Colors.blue[800],
              borderRadius: new BorderRadius.circular(10.0),
              // ),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.white70),
                    hintText: 'Email',
                    border:
                        // UnderlineInputBorder(
                        InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
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
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container loginButtonSection() {
    return Container(
      // width: double.infinity,
      // margin: EdgeInsets.fromLTRB(160, 30, 150, 0),
      // height: 40,
      margin: EdgeInsets.only(
        left: 90,
        right: 90,
        top: 35,
      ),
      child: Glassmorphism(
        blur: 20,
        opacity: 0.1,
        radius: 50.0,
        child: TextButton(
          // margin: EdgeInsets.only(top: 30.0),
          // padding: EdgeInsets.symmetric(horizontal: 20.0),
          // child: ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          //     backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          //   ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          // child: Text('Login'),
          onPressed: () async {
            // showGlassBottomSheet(
            //     context: context, child: GlassText("hello World", fontSize: 20));
            String email = emailController.text;
            String password = passwordController.text;
            UserLogin? data = await fetchDataLogin(email, password);
            print('info after login');
            var tokenReturn = token.substring(0, 8);

            Uri getUserPicUri = Uri();
            if (Constants.BASE_URL == "api.rostro-authentication.com") {
              getUserPicUri = Uri.https(
                  "${Constants.BASE_URL}", "/api/user/get_selfimages/");
            } else {
              getUserPicUri =
                  Uri.parse("${Constants.BASE_URL}/api/user/get_selfimages/");
            }
            //  print(tokenReturn);
            if (tokenReturn == "d_errors") {
              print(tokenReturn);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    //    title: const Text("Message!!"),
                    content: Text(
                      "The combination of email and password is not correct",
                    ),
                  );
                },
              );
            } else {
              var response = await http.get(getUserPicUri, headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Token $token'
              });
              pictures = json.decode(response.body);

              if (pictures['image_lists'].length > 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Homepage(token: token)),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UploadUserPics(token: token)),
                    (Route<dynamic> route) => false);
              }
            }
          },
          // child: GlassText("Login!"),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
      ),
    );

    //end of button
    // );
  }

  Row signUpButtonSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const GlassText('Do not have an account?'),
        TextButton(
          child: const GlassText(
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

  Row pwdrst() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      const GlassText('Forgot password?'),
      TextButton(
        child: const GlassText(
          'Password reset',
          style: TextStyle(fontSize: 15),
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const resetPassword(),
            ),
          ),
        },
      )
    ]);
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
