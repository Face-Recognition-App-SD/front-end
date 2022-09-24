import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import './register.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Regsec extends StatelessWidget {
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
              Positioned(
                top: 0,
                height: 400,
                width: 330,
                child: Avatar(),
              ),
              Positioned(
                top: 350,
                height: 600,
                width: 330,
                child: CDP(),
              ),
              Positioned(
                top: 490,
                height: 250,
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
                                hintText: "SSN",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
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
                                hintText: "Address",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Organization ID",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 690,
                height: 45,
                width: 250,
                child: ElevatedButton(
                  // color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CDP extends StatefulWidget {
  @override
  _CDPState createState() {
    return _CDPState();
  }
}

class _CDPState extends State {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              child: Text("Date of Birth"),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                showDatePicker();
              },
            ),
          ),
          SizedBox(height: 25),
          Text(
            selectedDate == null ? "" : "${selectedDate}".split(' ')[0],
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              if (value != null && value != selectedDate)
                setState(
                  () {
                    selectedDate = value;
                  },
                );
            },
            initialDateTime: DateTime.now(),
            minimumYear: 1900,
            maximumYear: 2023,
          ),
        );
      },
    );
  }
}
