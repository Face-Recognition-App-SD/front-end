// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import '../register.dart';
// import './regisnew.dart';
// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
// import 'models/loginclass.dart';
// import 'package:http/http.dart' as http;

// class Login extends StatefulWidget {
//   const Login({super.key});
//   @override
//   _LoginState createState() => _LoginState();
// }

// signIn(String email, String password) async {
//   Map data = {"email": email, "password": password};

//   var jsonData = null;
//   SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
//   var response = await http.post(Uri.http('10.32.219.74:8000', 'api/user/me/'),
//       headers: {
//         HttpHeaders.acceptHeader: 'application/json',
//       },
//       body: data);
//   if (response.statusCode == 200) {
//     jsonData = json.decode(response.body);
//     setState((){
//       SharedPreferences.setString("token",jsonData['token']);

//     })
//   } else
//     return null;
// }

// class _LoginState extends State<Login> {
//   LoginModel? logModel;
//   bool _isLoading = false;
//   TextEditingController userController = new TextEditingController();
//   TextEditingController emController = new TextEditingController();
//   TextEditingController pwController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var bg = 'assets/images/bg.jpeg';
//     return Material(
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(bg),
//             fit: BoxFit.cover,
//           ),
//         ), //background image
//         child: Container(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Positioned(
//                 // set a postion to the widget
//                 // alignment: Alignment.center,
//                 top: 90,
//                 height: 300,
//                 width: 300,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/logo.jpeg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ), //logo
//               Positioned(
//                 // set a postion to the widget
//                 top: 400,
//                 height: 150,
//                 width: 330,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment
//                       .spaceEvenly, //i dont know what exactly this do, i just put there because stackoverflow tells me to lol
//                   children: [
//                     Expanded(
//                       child: Row(
//                         //elements within this widget will be in row
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: TextField(
//                               //text input box
//                               decoration: InputDecoration(
//                                 labelText: "Username",
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(), //style
//                               ),
//                               controller:
//                                   userController, //decorate the input box
//                             ),
//                           ),
//                           IconButton(
//                             //reserved feature, facial recognition button
//                             icon: Image.asset('assets/images/facescan.jpeg'),
//                             iconSize: 60.0,
//                             color: Colors.blue, //styles
//                             onPressed: () => {
//                               print(
//                                   'anything'), //useless on press effect i just put there to check if it can works
//                             },
//                           ), //end of iconbutton
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 labelText: "Password",
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                               controller: pwController, //input box decoration
//                             ),
//                           ),
//                         ],
//                       ),
//                     ) //end of password input box widget
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 460,
//                 height: 250,
//                 width: 300,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       // color: Colors.blueAccent,
//                       onPressed: () => {
//                         Navigator.pop(context),
//                       },
//                       child: Text('Login'),
//                     ), //end of button
//                     ElevatedButton(
//                       // color: Colors.blueAccent,
//                       onPressed: () {
//                         setState(() {
//                           _isLoading = true;
//                         });

//                         // signIn(userController.text,pwController.text)

//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RegisNewFirst()));
//                       },
//                       child: Text('Register'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   } //button connects to register page
// }
