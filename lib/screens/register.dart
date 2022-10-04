// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import './register2.dart';
// <<<<<<< HEAD:lib/register.dart
// import 'package:http/http.dart' as http;
// import 'models/regist1class.dart';
// import 'dart:convert';
// =======
// >>>>>>> 2b51cfa13479a405f3188f4abbc2b227414f1065:lib/screens/register.dart

// class MyClip extends CustomClipper<Rect> {
//   Rect getClip(Size size) {
//     return Rect.fromLTWH(0, 0, 100, 100);
//   }

//   bool shouldReclip(oldClipper) {
//     return false;
//   }
// }

// class Avatar extends StatefulWidget {
//   @override
//   State<Avatar> createState() => _AvatarState();
// }

// class _AvatarState extends State<Avatar> {
//   File? image;
//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: image != null
//           ? ClipOval(
//               child: Image.file(
//                 image!,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//             )
//           : Image.asset('assets/images/icon_sample.jpeg'),
//     );
//   }
// <<<<<<< HEAD:lib/register.dart
// } //profile image

// Future<RegisterModel> httpGet() async {
//   final response = await http.get(
//       Uri.parse('http://localhost:8000/api/docs/#/user/user_create_create'));
//   if (response.statusCode == 200) {
//     return RegisterModel.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// =======
// >>>>>>> 2b51cfa13479a405f3188f4abbc2b227414f1065:lib/screens/register.dart
// }

// class Regfirst extends StatelessWidget {
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
//         ),
//         child: Container(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Positioned(
//                 top: 0,
//                 height: 400,
//                 width: 330,
//                 child: Avatar(),
//               ),
//               Positioned(
//                 top: 350,
//                 height: 300,
//                 width: 330,
//                 child: Column(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: "First name",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 40),
//                           Expanded(
//                             flex: 3,
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: "Last name",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                             ),
//                           ),
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
//                                 hintText: "Email",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 40),
//                           Expanded(
//                             flex: 3,
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: "Phone number",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                             ),
//                           ),
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
//                                 hintText: "Password",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                             ),
//                           ),
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
//                                 hintText: "Confirm Password",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                                 labelStyle: TextStyle(
//                                     fontSize: 24, color: Colors.white),
//                                 border: UnderlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 680,
//                 height: 45,
//                 width: 250,
//                 child: ElevatedButton(
//                   // color: Colors.blueAccent,
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Regsec()));
//                   },
//                   child: Text(
//                     'Next',
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
