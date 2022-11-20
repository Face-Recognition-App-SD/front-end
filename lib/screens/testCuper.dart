import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';
import 'package:rostro_app/screens/get_patient_pictures.dart';
import 'package:rostro_app/screens/patient_list.dart';
import '../utils/constant.dart';
import 'package:camera/camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TestCuper extends StatefulWidget {
  final String token;

  const TestCuper({super.key, required this.token});

  @override
  State<TestCuper> createState() => _TestCuper();
}

class _TestCuper extends State<TestCuper> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  
  static const double _kItemExtent = 32.0;

  var genderList = Constants.genderList;
  var statesList = Constants.statesList;

  //late Map<String, dynamic> pictures;
  late int id;
  XFile? picture;
  late List<XFile?> pictures;
 int _selectedFruit = 0;
  
  var indexNew;
  @override
  void StepState() {
    token = widget.token;
    super.initState();
    // selectedGenderVal =  Constants.genderList[0];
    // initCamera(widget.patients![0]);
  }

  // // ({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Patient'),
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
              addTextInfo(),
            
            ],
          ),
        ));
  }

  Widget addTextInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
         
 const SizedBox(height: 20.0),
          Row(
            children: [
              CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoPicker Sample'),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Selected fruit: '),
              CupertinoButton(
                padding: EdgeInsets.zero,
                // Display a CupertinoPicker with list of fruits.
                onPressed: () => showDialogState(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: _kItemExtent,
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        _selectedFruit = selectedItem;
                      });
                    },
                    children:
                        List<Widget>.generate(Constants.statesList.length, (int index) {
                      return Center(
                        child: Text(
                          Constants.statesList[index],
                        ),
                      );
                    }),
                  ),
                ),
                // This displays the selected fruit name.
                child: Text(
                  Constants.statesList[_selectedFruit],
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
              
            ],
          ),

        ],
      ),
    );
  }

 void showDialogState(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

}