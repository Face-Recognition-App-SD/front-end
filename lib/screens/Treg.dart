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
import 'package:flutter_signin_button/flutter_signin_button.dart';

class TRegister extends StatefulWidget {
  const TRegister({super.key});

  @override
  State<TRegister> createState() => _TRegister();
}

class _TRegister extends State<TRegister> {
  var bg = './assets/images/bg6.gif';
  bool _isLoading = false;
  late String token;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  // bool _isEqual = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      // ),
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
            // SubmitButtonSection(context),
            submitButton(context),
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
          height: 200,
          width: 190,
          fit: BoxFit.scaleDown,
        ));
    //background im
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpController = TextEditingController();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController department_idController = TextEditingController();

  var genderList = Constants.genderList;

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
            obscureText: !_passwordVisible1,
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
                  _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
                  // color: Theme.of(context).primaryColorDark,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible1 = !_passwordVisible1;
                  });
                },
              ),
              icon: Icon(Icons.lock, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            obscureText: !_passwordVisible2,
            keyboardType: TextInputType.text,
            controller: cpController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible2 ? Icons.visibility : Icons.visibility_off,
                  // color: Theme.of(context).primaryColorDark,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible2 = !_passwordVisible2;
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
                  items: genderList
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

  Container submitButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.white70,
      ),
      width: 40.0,
      height: 40,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: SignInButtonBuilder(
          text: 'Register with Email',
          icon: (Icons.email),
          backgroundColor: Colors.blue[700]!,
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;
            String cpassword = cpController.text;
            if (password.isNotEmpty &&
                cpassword.isNotEmpty &&
                password == cpassword) {
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
              print(data?.cpassword);

              if (data != null) {
                if (data.password != data.cpassword) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Alert Dialog Box"),
                      content: const Text("Both Password must be the same!"),
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

                  setState(() {});
                } else {
                  ShowDialogSucc(context);

                  setState(() {});
                }
              } else if (data == null) {
                print(
                    "YOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                print(data);

                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Alert Dialog Box"),
                    content: const Text("Please Input Account Information!"),
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

                setState(() {});
              } else {
                print(data);
                print(
                    "HELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");

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
                setState(() {});
              }
            }
          } //JJJJJJJJJJJJJJJJJJJJJ),
          ),
    );
  }

  // Container SubmitButtonSection(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 30.0),
  //     padding: EdgeInsets.symmetric(horizontal: 20.0),
  //     child: ElevatedButton(
  //         child: Text('Submit'),
  //         onPressed: () async {
  //           String email = emailController.text;
  //           String password = passwordController.text;
  //           String cpassword = cpController.text;
  //           if (password.isNotEmpty &&
  //               cpassword.isNotEmpty &&
  //               password == cpassword) {
  //             UserLogin? data = await fetchDataSignUp(
  //                 email,
  //                 password,
  //                 first_nameController.text,
  //                 last_nameController.text,
  //                 selectedValueforRoles ?? "Nurse",
  //                 department_idController.text,
  //                 selectedValueforGender ?? "Male");
  //             print('info after login');
  //             print(token);
  //             print(data?.cpassword);

  //             if (data != null) {
  //               if (data.password != data.cpassword) {
  //                 showDialog(
  //                   context: context,
  //                   builder: (ctx) => AlertDialog(
  //                     title: const Text("Alert Dialog Box"),
  //                     content: const Text("Both Password must be the same!"),
  //                     actions: <Widget>[
  //                       TextButton(
  //                         onPressed: () {
  //                           Navigator.of(ctx).pop();
  //                         },
  //                         child: Container(
  //                           color: Color.fromARGB(236, 9, 96, 168),
  //                           padding: const EdgeInsets.all(14),
  //                           child: const Text("OK"),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );

  //                 setState(() {});
  //               } else {
  //                 ShowDialogSucc(context);

  //                 setState(() {});
  //               }
  //             } else if (data == null) {
  //               print(
  //                   "YOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
  //               print(data);

  //               showDialog(
  //                 context: context,
  //                 builder: (ctx) => AlertDialog(
  //                   title: const Text("Alert Dialog Box"),
  //                   content: const Text("Please Input Account Information!"),
  //                   actions: <Widget>[
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(ctx).pop();
  //                       },
  //                       child: Container(
  //                         color: Color.fromARGB(236, 9, 96, 168),
  //                         padding: const EdgeInsets.all(14),
  //                         child: const Text("OK"),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );

  //               setState(() {});
  //             } else {
  //               print(data);
  //               print(
  //                   "HELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");

  //               showDialog(
  //                 context: context,
  //                 builder: (ctx) => AlertDialog(
  //                   title: const Text("Alert Dialog Box"),
  //                   content: const Text("User with this email already exists"),
  //                   actions: <Widget>[
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(ctx).pop();
  //                       },
  //                       child: Container(
  //                         color: Color.fromARGB(236, 9, 96, 168),
  //                         padding: const EdgeInsets.all(14),
  //                         child: const Text("OK"),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //               setState(() {});
  //             }
  //           }
  //         } //JJJJJJJJJJJJJJJJJJJJJ

  //         //end of button
  //         ),
  //   );
  // }

  Future<UserLogin?> fetchDataSignUp(
      String email,
      String password,
      String first_name,
      String last_name,
      String role,
      String dep,
      String gender) async {
    Uri myRegUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myRegUri = Uri.https(Constants.BASE_URL, '/api/user/create/');
    } else {
      myRegUri = Uri.parse('${Constants.BASE_URL}/api/user/create/');
    }
    var response = await http.post(myRegUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
    }, body: {
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
