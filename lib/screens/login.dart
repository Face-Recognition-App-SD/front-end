import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/regisnew.dart';

import './regisnew.dart';

class Login extends StatelessWidget {
  var bg = 'assets/images/bg.jpeg';
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                // set a postion to the widget
                // alignment: Alignment.center,
                top: 90,
                height: 300,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ), //logo
              Positioned(
                // set a postion to the widget
                top: 400,
                height: 150,
                width: 330,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, //i dont know what exactly this do, i just put there because stackoverflow tells me to lol
                  children: [
                    Expanded(
                      child: Row(
                        //elements within this widget will be in row
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              //text input box
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                border: UnderlineInputBorder(), //style
                              ), //decorate the input box
                            ),
                          ),
                          IconButton(
                            //reserved feature, facial recognition button
                            icon: Image.asset('assets/images/facescan.jpeg'),
                            iconSize: 60.0,
                            color: Colors.blue, //styles
                            onPressed: () => {
                              print(
                                  'anything'), //useless on press effect i just put there to check if it can works
                            },
                          ), //end of iconbutton
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
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                border: UnderlineInputBorder(),
                              ), //input box decoration
                            ),
                          ),
                        ],
                      ),
                    ) //end of password input box widget
                  ],
                ),
              ),
              Positioned(
                top: 460,
                height: 250,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      // color: Colors.blueAccent,
                      onPressed: () => {
                        Navigator.pop(context),
                      },
                      child: Text('Login'),
                    ), //end of button
                    ElevatedButton(
                      // color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisNewFirst()));
                      },
                      child: Text('Register'),
                    ), //button connects to register page
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
