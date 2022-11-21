import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/login_page.dart';
import './regisnew.dart';
import '../admins/admin_login.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../utils/Glassmorphism.dart';

class FirstPage extends StatelessWidget {
  var bg = 'assets/images/bg6.gif';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            //create a container space to wrap around the entire page
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bg),
                fit: BoxFit.cover,
              ), // neccessary widgets for setting up background image
            ),
            child: Container(
                //set another container
                child: Stack(
                    //stack widget helps to contain multiple sub widgets
                    alignment: Alignment.center,
                    children: [
                  Positioned(
                    //position widget lets us set the position of the element
                    // alignment: Alignment.center,
                    top: 90,
                    height: 300,
                    width: 300,
                    child: Container(
                      //another container
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.jpeg'),
                          fit: BoxFit.cover,
                        ), //logo
                      ),
                    ),
                  ), //end of first Positioned widget
                  Positioned(
                    //second positioned
                    top: 450,
                    height: 1000,
                    width: 250,
                    child: IntrinsicWidth(
                      // I forgot what this does, but i think this helps to stretch the width so that the container box can have the full width of the screen
                      child: Column(
                        //column widget, so all the sub widgets within this will be in column
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch, // stretch
                        children: [
                          Glassmorphism(
                            blur: 20,
                            opacity: 0.1,
                            radius: 50.0,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    child: const Text("User Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        )))),
                          ),
                          // Container(
                          //   height: 45,
                          //   width: double.infinity,

                          //   child: GlassFlexContainer(
                          //     // user login button below admin login button
                          //     child: Padding(
                          //       padding: EdgeInsets.all(0),
                          //       // margin: EdgeInsets.fromLTRB(80, 0, 85, 0),
                          //       child: GlassButton(
                          //         linearGradient: LinearGradient(
                          //           colors: [
                          //             Colors.blue.withOpacity(0.5),
                          //             Colors.blue.withOpacity(0.4),
                          //           ],
                          //         ),

                          //         // color: Colors.blueAccent,
                          //         onPressed: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => LoginPage()));
                          //         }, // on press effect directs to the login page from login.dart
                          //         child: GlassText(
                          //           'User Login',
                          //         ), //print user login on the button
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          const SizedBox(
                              height:
                                  20), //set a space in between the two buttons
                          Glassmorphism(
                            blur: 20,
                            opacity: 0.1,
                            radius: 50.0,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminLoginPage(),
                                  ),
                                );
                              }, //no on press effect yet
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5,
                                ),
                                child: const Text(
                                  "Admin Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
    //print admin login on the button
  }
} //a bunch of brackets lol
