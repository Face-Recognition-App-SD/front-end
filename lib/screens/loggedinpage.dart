import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Logged extends StatefulWidget {
  @override
  _LoggedState createState() => _LoggedState();
}

class _LoggedState extends State<Logged> {
  @override
  void initState() {
    super.initState();
  }

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
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
          ),
          Positioned(
            top: 430,
            height: 300,
            width: 320,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    child: Column(
                      children: [
                        Spacer(flex: 1),
                        Positioned(
                          top: 40,
                          height: 300,
                          width: 300,
                          child: Text('Welcome'),
                        ),
                        Spacer(flex: 3),
                        ElevatedButton(
                          child: Text('View Patients'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Patients'),
                                content: Container(
                                    child: ExpansionTile(
                                        title: Text('Patient Names'),
                                        children: [Text("patient")])),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 60,
                          height: 300,
                          width: 300,
                          child: Text('Wishing you a great working day'),
                        ),
                        Spacer(flex: 3),
                        ElevatedButton(
                            onPressed: () => print('anything'),
                            child: Text('Verify patient\'s identity')),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        // child: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.green,
        );
    // ); //background image
  }
}
