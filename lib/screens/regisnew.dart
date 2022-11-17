import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rostro_app/screens/login_page.dart';

import '../utils/constant.dart';
import './homepage.dart';
import './login_page.dart';
import 'dart:io';
import './verifyEmail.dart';
//import 'loggedinpage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;
  late String token;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController department_idController = TextEditingController();

  final List<String> gender = ['Male', 'Female', 'Transgender', 'Non-binary'];

  final List<String> roles = ['Doctor', 'Nurse', 'Physical Therapist'];
  String? selectedValueforGender;
  String? selectedValueforRoles;

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: 'Email',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            obscureText: !_passwordVisible,
            keyboardType: TextInputType.text,
            controller: passwordController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
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
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: first_nameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'First name',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: last_nameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Last name',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.local_hospital, color: Colors.white70),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text(
                    '     Roles',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  items: roles
                      .map((roles) => DropdownMenuItem<String>(
                            value: roles,
                            child: Text(
                              roles,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValueforRoles,
                  onChanged: (value) {
                    setState(() {
                      selectedValueforRoles = value as String;
                    });
                  },
                  buttonHeight: 30,
                  buttonWidth: 200,
                  itemHeight: 30,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color.fromARGB(236, 9, 96, 168),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: department_idController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Department ID',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.white70),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text(
                    '     Gender',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  items: gender
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValueforGender,
                  onChanged: (value) {
                    setState(() {
                      selectedValueforGender = value as String;
                    });
                  },
                  buttonHeight: 30,
                  buttonWidth: 200,
                  itemHeight: 30,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(236, 9, 96, 168),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
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
            String email = emailController.text;
            String password = passwordController.text;
            UserLogin? data = await fetchDataSignUp(
                email,
                password,
                first_nameController.text,
                last_nameController.text,
                selectedValueforRoles ?? "Nurse",
                department_idController.text,
                selectedValueforGender ?? "Male");
            print('info after login');
            print(token);

            if (data != null) {
              ShowDialogSucc(context);

              setState(() {});
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => Homepage(token: token)),
              //     (Route<dynamic> route) => false);
            } else {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Alert Dialog Box"),
                  content: const Text("User with this email already exists"),
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

  Future<UserLogin?> fetchDataSignUp(
      String email,
      String password,
      String first_name,
      String last_name,
      String role,
      String dep,
      String gender) async {
    //var myRegUri = Uri.https(Constants.BASE_URL, '/api/user/create/');
    var myRegUri = Uri.parse('${Constants.BASE_URL}/api/user/create/');
    var response = await http.post(myRegUri,
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: {
          "email": email,
          "password": password,
          "first_name": first_name,
          "last_name": last_name,
          "role": role,
          "department_id": dep,
          "gender": gender,
        });
    var jsonResponse = null;
    var data = response.body;
    token = data.substring(10, data.length - 2);
    if (response.statusCode == 201) {
      String responseString = response.body;

      setState(() {
        _isLoading = false;
      });

      return albumFromJson(responseString);
    } else {
      if (response.statusCode == 400) {
        String responseString = response.body;

        print(responseString);
      }
      return null;
    }
  }

  Widget? ShowDialogSucc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Message!"),
          content: new Text(
              "Your account have been created. Please check your email to verify your account."),
          actions: <Widget>[
            new TextButton(
              child: new Text("Verify Email"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VerifyEmail(
                            email: emailController.text,
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
