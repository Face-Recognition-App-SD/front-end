import 'package:flutter/material.dart';
import 'package:rostro_app/screens/login_page.dart';
import '../admins/admin_login.dart';

class FirstPage extends StatelessWidget {
  var bg = 'assets/images/bg.jpeg';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //create a container space to wrap around the entire page
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
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
                height: 100,
                width: 250,
                child: IntrinsicWidth(
                  // I forgot what this does, but i think this helps to stretch the width so that the container box can have the full width of the screen
                  child: Column(
                    //column widget, so all the sub widgets within this will be in column
                    crossAxisAlignment: CrossAxisAlignment.stretch, // stretch
                    children: [
                      
                    
                      Expanded(
                        // user login button below admin login button
                        flex: 3,
                        child: ElevatedButton(
                          // color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }, // on press effect directs to the login page from login.dart
                          child: const Text('User Login'),
                        ),
                      ),
                      const Spacer(), //set a space in between the two buttons
                      Expanded(
                        //allow the button to stretch? i think thats what i did
                        flex: 3, //set the height
                        child: ElevatedButton(
                          // a type of button
                          //color: Colors.blueAccent,
                          onPressed: () { Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminLoginPage()));}, //no on press effect yet
                          child: const Text('Admin Login'), //print admin login on the button
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //a bunch of brackets lol
