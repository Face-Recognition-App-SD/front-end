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

String? selectedValueforState;

class AddNewPatient extends StatefulWidget {
  final String token;

  const AddNewPatient({super.key, required this.token});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  String? selectedGenderVal = "";
  String? selectedState = "";
  String? selectedCountry = "";
  String? selectedCity = "";
  static const double _kItemExtent = 32.0;
  int selectedStateItem = 0;
  var genderList = Constants.genderList;

  static const List<String> _stateNames = Constants.statesList;

  late int id;
  XFile? picture;
  late List<XFile?> pictures;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController medListController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityAddressController = TextEditingController();
  TextEditingController zipcodeAddressController = TextEditingController();
  TextEditingController stateAddressController = TextEditingController();
  TextEditingController emergencyContactNameController = TextEditingController();
  TextEditingController emergencyPhoneNumberController = TextEditingController();
  TextEditingController relationshipController = TextEditingController(); //
  TextEditingController genderController = TextEditingController();
  TextEditingController isInHospitalController = TextEditingController();
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
          TextFormField(
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
          const SizedBox(height: 20.0),
          TextFormField(
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
          const SizedBox(height: 20.0),
          TextFormField(
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
          const SizedBox(height: 20.0),
          TextFormField(
            controller: medListController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            decoration: const InputDecoration(
              icon: Icon(Icons.local_hospital_outlined, color: Colors.white70),
              hintText: 'Medical List',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: phoneNumberController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            decoration: const InputDecoration(
              icon: Icon(Icons.numbers, color: Colors.white70),
              hintText: 'Phone Number',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: dateOfBirthController,
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            decoration: const InputDecoration(
              icon: Icon(Icons.date_range, color: Colors.white70),
              hintText: 'Date of birth yyyy-mm-dd',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
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
                    color: const Color.fromARGB(236, 9, 96, 168),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: streetAddressController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            decoration: const InputDecoration(
              icon: Icon(Icons.house, color: Colors.white70),
              hintText: 'Street Address',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: cityAddressController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            decoration: const InputDecoration(
              icon: Icon(Icons.house, color: Colors.white70),
              hintText: 'City Address',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: zipcodeAddressController,
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            decoration: const InputDecoration(
              icon: Icon(Icons.house, color: Colors.white70),
              hintText: 'Zipcode',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white70),
              Cuper(context),
            ],
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: emergencyContactNameController,
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
          const SizedBox(height: 20.0),
          TextFormField(
            controller: emergencyPhoneNumberController,
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
        ],
      ),
    );
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
              }
            }));
  }

  Widget addPhotos() {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
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
      "med_list": medListController.text,
      "phone_number": phoneNumberController.text,
      "date_of_birth": dateOfBirthController.text,
      "street_address": streetAddressController.text,
      "city_address": cityAddressController.text,
      "zipcode_address": zipcodeAddressController.text,
      "state_address": selectedValueforState,
      "emergency_contact_name": emergencyContactNameController.text,
      "emergency_phone_number": emergencyPhoneNumberController.text,
      "relationship": relationshipController.text,
      "gender": selectedValueforGender,
    });

    var data = json.decode(res.body);
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
