import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../utils/Glassmorphism.dart';

// import '../screens/testCuper.dart';
String? selectedValueforState;

class AddNewPatient extends StatefulWidget {
  final String token;

  const AddNewPatient({super.key, required this.token});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  var bg = './assets/images/bg6.gif';
  late String token;
  String? selectedGenderVal = "";
  String? selectedState = "";
  String? selectedCountry = "";
  String? selectedCity = "";
  static const double _kItemExtent = 32.0;
  int selectedStateItem = 0;
  var genderList = Constants.genderList;

  static const List<String> _stateNames = Constants.statesList;

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
  String? selectedValueforState;
  var indexNew;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = widget.token;
    selectedValueforState = "";
  }

  // // ({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Patient'),
          backgroundColor: Colors.blueAccent,
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
              addPhotos(),
              submitButton(context),
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
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: firstNameController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.white70),
                    hintText: 'First Name',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white70,
                    )),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: lastNameController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.white70),
                    hintText: 'Last Name',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.numbers_rounded, color: Colors.white70),
                    hintText: 'Age',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: med_listController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.local_hospital_outlined,
                        color: Colors.white70),
                    hintText: 'Medical List',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phone_numberController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.numbers, color: Colors.white70),
                    hintText: 'Phone Number',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: date_of_birthController,
                  keyboardType: TextInputType.datetime,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range, color: Colors.white70),
                    hintText: 'Date of birth yyyy-mm-dd',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.white70),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: const Text(
                          '     Gender',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        items: genderList
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValueforGender,
                        onChanged: (value) {
                          setState(() {
                            selectedValueforGender = value as String;
                            token = widget.token;
                          });
                        },
                        buttonHeight: 30,
                        buttonWidth: 200,
                        itemHeight: 30,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(236, 9, 96, 168),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: street_addressController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.house, color: Colors.white70),
                    hintText: 'Street Address',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: city_addressController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.house, color: Colors.white70),
                    hintText: 'City Address',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: zipcode_addressController,
                  keyboardType: TextInputType.datetime,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.house, color: Colors.white70),
                    hintText: 'Zipcode',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.white70),
                    Cuper(context),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: emergency_contact_nameController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.white70),
                    hintText: 'Emergency Contact Name',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: GlassContainer(
              borderRadius: new BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: emergency_phone_numberController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.numbers, color: Colors.white70),
                    hintText: 'Emergency Contact Phone Number',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20, left: 55, right: 55),
        child: Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: 50.0,
            child: TextButton(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    )),
                // child: const Text('Submit'),
                onPressed: () async {
                  PatientsData? data = await postPatient();
                  if (data != null) {
                    _showDialog(context, token);

                    // setState(() {});
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => Homepage(token: token)),
                    //     (Route<dynamic> route) => false);
                  }
                })));
  }

  Widget addPhotos() {
    return Container(
      margin: EdgeInsets.only(left: 55, right: 55, top: 20),
      // color: Colors.transparent,
      child: Glassmorphism(
          blur: 20,
          opacity: 0.1,
          radius: 50.0,
          // decoration: const BoxDecoration(
          //   //color: Color.fromARGB(255, 199, 201, 224),
          //   shape: BoxShape.rectangle,
          //   //borderRadius: BorderRadius.all(Radius.circular(5.0))
          // ),
          child: TextButton(
            // style: TextButton.styleFrom(
            //   textStyle: const TextStyle(
            //     fontSize: 18,
            //     color: Color.fromARGB(30, 0, 0, 0),
            //     decoration: TextDecoration.underline,
            //   ),
            // ),
            // child: const Text('Add Photo'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: const Text(
                "Add Photo",
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
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
    Uri addPatientTextUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      addPatientTextUri =
          Uri.https(Constants.BASE_URL, '/api/patients/patientss/');
    } else {
      addPatientTextUri =
          Uri.parse("${Constants.BASE_URL}/api/patients/patientss/");
    }
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
      "state_address": selectedValueforState,
      "emergency_contact_name": emergency_contact_nameController.text,
      "emergency_phone_number": emergency_phone_numberController.text,
      "relationship": relationshipController.text,
      "gender": selectedValueforGender,
    });

    var data = json.decode(res.body);
    print(data);
    id = data['id'];
    Uri addPatientPictures = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      addPatientPictures = Uri.https(
          Constants.BASE_URL, '/api/patients/patientss/$id/upload-image/');
    } else {
      addPatientPictures = Uri.parse(
          "${Constants.BASE_URL}/api/patients/patientss/$id/upload-image/");
    }
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
      //  setState(() {});
      return patientFromJson(responseString);
    } else {
      return null;
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

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialogCuper(Widget child) {
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

//TextStyle get pickerTextStyle => _pickerTextStyle ?? _defaults.pickerTextStyle;
  @override
  Widget Cuper(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Row(
          children: <Widget>[
            const Text(
              'State: ',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,

              // Display a CupertinoPicker with list of fruits.
              onPressed: () => _showDialogCuper(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: _kItemExtent,
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      selectedStateItem = selectedItem;
                      token = token;

                      selectedValueforState = _stateNames[selectedStateItem];
                    });
                  },
                  children:
                      List<Widget>.generate(_stateNames.length, (int index) {
                    return Text(
                      _stateNames[index],
                    );
                  }),
                ),
              ),
              // This displays the selected fruit name.
              child: Text(
                _stateNames[selectedStateItem],
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
