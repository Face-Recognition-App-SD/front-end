import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';

import '../utils/constant.dart';
import 'dart:io';
import './verifyEmail.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController departmentIdController = TextEditingController();

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
            style: const TextStyle(color: Colors.white70, fontSize: 13),
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
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Password',
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: const TextStyle(color: Colors.white70),
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
              icon: const Icon(Icons.lock, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: firstNameController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
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
            controller: lastNameController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
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
            controller: departmentIdController,
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
                firstNameController.text,
                lastNameController.text,
                selectedValueforRoles ?? "Nurse",
                departmentIdController.text,
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
           print("inside fetch 1");
    Uri myRegUri = Uri();
    if(Constants.BASE_URL == "api.rostro-authentication.com"){
      myRegUri = Uri.https(Constants.BASE_URL, '/api/user/create/');
    }
    else{
      myRegUri = Uri.parse('${Constants.BASE_URL}/api/user/create/');
    }
    var response = await http.post(myRegUri,
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Token $token',
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

     
      print("inside fetch");
      print (responseString);

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
