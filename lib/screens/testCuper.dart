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

class CupertinoPickerExample1 extends StatefulWidget {
  final String token;
   final String? state;

  const CupertinoPickerExample1({super.key, required this.token, this.state});

  @override
  State<CupertinoPickerExample1> createState() => _CupertinoPickerExampleState1();
}

class _CupertinoPickerExampleState1 extends State<CupertinoPickerExample1> {
  int selectedState = 0;
  late String token;
  late String? state;
  static const double _kItemExtent = 32.0;
  static const List<String> _stateNames = Constants.statesList;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
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

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
          
            backgroundColor: Colors.transparent,
           
                
              child: Row(
                
                children: <Widget>[
                  const Text('State: ',  style: TextStyle(color: Colors.white70,  fontSize: 16),),
                  
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    

                    // Display a CupertinoPicker with list of fruits.
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            selectedState = selectedItem;
                            token= widget.token;
                            state =  _stateNames[selectedState];
                             Navigator.pop(context, selectedState);
                          });
                        },
                        children: List<Widget>.generate(_stateNames.length,
                            (int index) {
                          return Text(
                              _stateNames[index],
                            
                          );
                        }),
                      ),
                    ),
                    // This displays the selected fruit name.
                    child: Text(
                      _stateNames[selectedState],
                      style: const TextStyle(
                        fontSize: 16.0,
                         color: Colors.white70,
                      ),
                    ),
                    
                  ),
                   
                ],
              
            
        
        ),
      
    );
  }
}



