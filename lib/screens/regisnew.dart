import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import '../models/class.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class RegisNewFirst extends StatefulWidget {
  const RegisNewFirst({super.key});
  @override
  _RegisNewFirstState createState() => _RegisNewFirstState();
}

Future<UserInfo?> fetchData(
    String email, String password, String first_name) async {
  var response = await http.post(
    //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
       Uri.http('192.168.1.80:8000', 'api/user/create/'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: {
        "email": email,
        "password": password,
        "first_name": first_name
      });
  var data = response.body;
  print(data);
  if (response.statusCode == 201) {
    String responseString = response.body;
    return albumFromJson(responseString);
  } else {
    return null;
  }
}

class _RegisNewFirstState extends State<RegisNewFirst> {
  UserInfo? albumModel;
  TextEditingController fnController = TextEditingController();
  TextEditingController emController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var bg = 'assets/images/bg.jpeg';
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Positioned(
              //   top: 0,
              //   height: 400,
              //   width: 330,
              //   child: Avatar(),
              // ),
              Positioned(
                top: 350,
                height: 300,
                width: 330,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "First name",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                border: UnderlineInputBorder(),
                              ),
                              controller: fnController,
                            ),
                          ),
                          SizedBox(width: 40),
                          // Expanded(
                          //   flex: 3,
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       hintText: "Last name",
                          //       hintStyle: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 25,
                          //       ),
                          //       labelStyle: TextStyle(
                          //           fontSize: 24, color: Colors.white),
                          //       border: UnderlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                border: UnderlineInputBorder(),
                              ),
                              controller: emController,
                            ),
                          ),
                          SizedBox(width: 40), //set a spacer
                          // Expanded(
                          //   flex: 3,
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       hintText: "Phone number",
                          //       hintStyle: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 25,
                          //       ),
                          //       labelStyle: TextStyle(
                          //           fontSize: 24, color: Colors.white),
                          //       border: UnderlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                border: UnderlineInputBorder(),
                              ),
                              controller: pwController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 3,
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             hintText: "Confirm Password",
                    //             hintStyle: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 25,
                    //             ),
                    //             labelStyle: TextStyle(
                    //                 fontSize: 24, color: Colors.white),
                    //             border: UnderlineInputBorder(),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                top: 680,
                height: 45,
                width: 250,
                child: ElevatedButton(
                  // color: Colors.blueAccent,
                  onPressed: () async {
                    String email = emController.text;
                    String password = pwController.text;
                    String firstName = fnController.text;
                    UserInfo? data = await fetchData(email, password, firstName);

                    setState(() {
                      albumModel = data;
                      print(albumModel);
                    });
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => Regsec()));
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              // Column(children: [
              //   InkWell(child:Text("whatever"),
              //   onTap:(){
              //     httpGet().then((Album value)){
              //       setState((){httpGetResult = "HTTP GET 请求结果 :\nuserid:${value.icon}\n"+"title:${value.title}\nurl:${value.url}";});
              //     }
              //   }
              // ],)
            ],
          ),
        ),
      ),
    );
  }
}
