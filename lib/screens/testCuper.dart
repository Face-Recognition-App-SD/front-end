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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController med_listController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
  TextEditingController date_of_birthController = TextEditingController();
  TextEditingController street_addressController = TextEditingController();
  TextEditingController city_addressController = TextEditingController();
  TextEditingController zipcode_addressController = TextEditingController();
  TextEditingController state_addressController = TextEditingController();
  TextEditingController emergency_contact_nameController =
      TextEditingController();
  TextEditingController emergency_phone_numberController =
      TextEditingController();
  TextEditingController relationshipController = TextEditingController(); //
  TextEditingController genderController = TextEditingController();
  TextEditingController is_in_hospitalController = TextEditingController();
  String? selectedValueforGender;
  var index;
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
                        index = selectedItem;
                          token = widget.token;
                      });
                    },
                    children:
                        List<Widget>.generate(statesList.length, (int index) {
                      return Center(
                        child: Text(
                          statesList[index],
                        ),
                      );
                    }),
                  ),
                ),
                // This displays the selected fruit name.
                child: Text(
                statesList[index],
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

  Widget submitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              PatientsData? data = await postPatient();
              if (data != null) {
                _showDialog(context, token);

                setState(() {});
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => Homepage(token: token)),
                //     (Route<dynamic> route) => false);
              }
            }));
  }

  Widget addPhotos() {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 199, 201, 224),
            shape: BoxShape.rectangle,
            //borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(30, 0, 0, 0),
                decoration: TextDecoration.underline,
              ),
            ),
            child: const Text('Add Photo'),
            onPressed: () async {
              pictures = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetPatientPictures(token: token)));
            },
          )),
    );
  }

  Future<PatientsData?> postPatient() async {
    var addPatientTextUri =
        Uri.https(Constants.BASE_URL, '/api/patients/patientss/');
    //var addPatientTextUri = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/");
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    final res = await http.post(addPatientTextUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    }, body: {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "age": ageController.text,
      "med_list": med_listController.text,
      "phone_number": phone_numberController.text,
      "date_of_birth": date_of_birthController.text,
      "street_address": street_addressController.text,
      "city_address": city_addressController.text,
      "zipcode_address": zipcode_addressController.text,
      "state_address": statesList[index],
      "emergency_contact_name": emergency_contact_nameController.text,
      "emergency_phone_number": emergency_phone_numberController.text,
      "relationship": relationshipController.text,
      "gender": genderController.text,
    });

    var data = json.decode(res.body);
    print(data);
    id = data['id'];
    var addPatientPictures = Uri.https(
        Constants.BASE_URL, '/api/patients/patientss/$id/upload-image/');
    //var addPatientPictures = Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/upload-image/");
    var request = http.MultipartRequest("POST", addPatientPictures);
    request.headers.addAll({"Authorization": "Token $token"});
    request.fields['id'] = id.toString();
    var image1 =
        await http.MultipartFile.fromPath("image_lists", pictures[0]!.path);
    request.files.add(image1);
    var image2 =
        await http.MultipartFile.fromPath("image_lists", pictures[1]!.path);
    request.files.add(image2);
    var image3 =
        await http.MultipartFile.fromPath("image_lists", pictures[2]!.path);
    request.files.add(image3);

    http.StreamedResponse response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Navigator.of(context).pop();
    if (res.statusCode < 300 && res.statusCode > 199) {
      String responseString = res.body;
      setState(() {});
      return patientFromJson(responseString);
    } else {
      return null;
    }
  }
}

Widget? _showDialog(BuildContext context, String token) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Message!!"),
        content: const Text("New patient has been created successfully!"),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PatientList(
                          token: token,
                        )),
              );
            },
          ),
        ],
      );
    },
  );
}
