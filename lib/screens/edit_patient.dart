import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/patient_list.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rostro_app/models/patientsdata.dart';

import '../utils/constant.dart';
import '../screens/delete.dart';

import 'package:camera/camera.dart';
import 'package:rostro_app/screens/get_patient_pictures.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../utils/Glassmorphism.dart';

List<String> genders = <String>[
  'Male',
  'Female',
  'Transgender',
  'Non-binary/non-conforming',
  'Prefer not to respond'
];
String genero = 'none';
List<String> states = <String>[
  "Alaska",
  "Alabama",
  "Arkansas",
  "American Samoa",
  "Arizona",
  "California",
  "Colorado",
  "Connecticut",
  "District of Columbia",
  "Delaware",
  "Florida",
  "Georgia",
  "Guam",
  "Hawaii",
  "Iowa",
  "Idaho",
  "Illinois",
  "Indiana",
  "Kansas",
  "Kentucky",
  "Louisiana",
  "Massachusetts",
  "Maryland",
  "Maine",
  "Michigan",
  "Minnesota",
  "Missouri",
  "Mississippi",
  "Montana",
  "North Carolina",
  "North Dakota",
  "Nebraska",
  "New Hampshire",
  "New Jersey",
  "New Mexico",
  "Nevada",
  "New York",
  "Ohio",
  "Oklahoma",
  "Oregon",
  "Pennsylvania",
  "Puerto Rico",
  "Rhode Island",
  "South Carolina",
  "South Dakota",
  "Tennessee",
  "Texas",
  "Utah",
  "Virginia",
  "Virgin Islands",
  "Vermont",
  "Washington",
  "Wisconsin",
  "West Virginia",
  "Wyoming"
];
String estado = 'none';

class EditPatient extends StatefulWidget {
  final String token;
  final Map<String, dynamic> details;

  const EditPatient({
    super.key,
    required this.token,
    required this.details,
  });

  @override
  State<EditPatient> createState() => ExtendEditPatient();
}

class ExtendEditPatient extends State<EditPatient> {
  var bg = 'assets/images/bg1.gif';
  late Map<String, dynamic> details = widget.details;
  late String token = widget.token;
  late String nm = widget.details['first_name'];
  late int id = widget.details['id'];
  List<XFile?> pictures = [];
  // TextEditingController idController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController medListController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityAddressController = TextEditingController();
  TextEditingController zipcodeAddressController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController emergencyContactNameController =
      TextEditingController();
  TextEditingController emergencyPhoneNumber = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Edit Patient $nm [ ID: $id ]"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  delete(id, token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PatientList(
                              token: token,
                            )),
                  );
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(), //background image
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                const SizedBox(height: 10.0),
                // Text(
                //   "\t\t ID: $id",
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(fontSize: 20, color: Colors.black),
                // ),
                const SizedBox(height: 10.0),
                textData(),
                getImages(context),
                submitButton(context),
              ],
            ),
          ),
        ));
  }

  delete(int id, String token) async {
    var rest = await deletePatient(id, token);
    setState(() {});
  }

  Widget getImages(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
        child: Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: 50.0,
            child:
                // padding: const EdgeInsets.symmetric(horizontal: 20.0),

                TextButton(
              // child: const Text('Update Images'),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                child: const Text("Update Image",
                    style: TextStyle(color: Colors.black, fontSize: 13.0)),
              ),
              onPressed: () async {
                pictures = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GetPatientPictures(token: token)));
              },
            )));
  }

  Future<bool> editPatientInfo() async {
    Uri addPatientTextUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      addPatientTextUri =
          Uri.https(Constants.BASE_URL, '/api/patients/patientss/$id/');
    } else {
      addPatientTextUri =
          Uri.parse("${Constants.BASE_URL}/api/patients/patientss/$id/");
    }
    final res = await http.patch(addPatientTextUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    }, body: {
      'first_name': firstnameController.text,
      'last_name': lastnameController.text,
      'phone_number': phoneNumberController.text,
      'age': ageController.text,
      'med_list': medListController.text,
      'zipcode_address': zipcodeAddressController.text,
      'gender': genero,
      'state_address': estado
    });
    return true;
  }

  Future<bool> updateImages() async {
    if (pictures.isNotEmpty) {
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

      if (response.statusCode > 199 && response.statusCode < 300) {
        return true;
      }
    }
    return false;
  }

  Widget textData() {
    firstnameController.text = details['first_name'];
    lastnameController.text = details['last_name'];
    ageController.text = details['age'].toString();
    medListController.text = details['med_list'] ?? 'Not provided';
    phoneNumberController.text = details['phone_number'] ?? 'Not provided';
    dobController.text = details['date_of_birth'] ?? "0000-00-000";
    genderController.text = details['gender'] ?? "null";
    streetAddressController.text = details['street_address'];
    cityAddressController.text = details['city_address'];
    zipcodeAddressController.text = details['zipcode_address'];
    linkController.text = details['link'];
    emergencyContactNameController.text = details['emergency_contact_name'];
    emergencyPhoneNumber.text = details['emergency_phone_number'];

    return Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // const SizedBox(height: 20.0),

              GlassContainer(
                borderRadius: new BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Firstname:",
                          // textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: firstnameController,
                        cursorColor: Colors.black,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person, color: Colors.black),
                          // hintText: 'DepartID',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GlassContainer(
                borderRadius: new BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "\t Lastname:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: lastnameController,
                        cursorColor: Colors.black,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person, color: Colors.black),
                          // hintText: 'DepartID',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GlassContainer(
                borderRadius: new BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: const Text(
                          "\t Age:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: ageController,
                        cursorColor: Colors.black,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person, color: Colors.black),
                          // hintText: 'DepartID',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GlassContainer(
                borderRadius: new BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "\t Medical List:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: medListController,
                        cursorColor: Colors.black,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.local_hospital_outlined,
                              color: Colors.black),
                          // hintText: 'DepartID',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GlassContainer(
                borderRadius: new BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "\t Phone Number:",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        cursorColor: Colors.black,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.local_hospital_outlined,
                              color: Colors.black),
                          // hintText: 'DepartID',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GlassContainer(
                  width: double.infinity,
                  borderRadius: new BorderRadius.circular(10.0),
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "\t State:",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          DropDownState(),
                          SizedBox(height: 20.0),
                          Text(
                            "\t Gender:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          DropDownGender(),
                        ],
                      )))
            ]));
  }

  Widget? _showDialog(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message!!"),
          content:
              const Text("Patient information has been edited successfully!"),
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

  Widget submitButton(BuildContext context) {
    var resPics = false;
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: const Text('Submit'),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          var resText = await editPatientInfo();
          if (pictures.isNotEmpty) {
            resPics = await updateImages();
          }
          Navigator.of(context).pop();
          if (resText || resPics) {
            _showDialog(context, token);
          }
        },
      ),
    );
  }
}

class DropDownGender extends StatefulWidget {
  const DropDownGender({super.key});

  State<DropDownGender> createState() => _DropDownGender();
}

class _DropDownGender extends State<DropDownGender> {
  String gender = genders.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: gender,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          gender = value!;
          genero = value;
        });
      },
      items: genders.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          alignment: Alignment.centerRight,
        );
      }).toList(),
    );
  }
}

class DropDownState extends StatefulWidget {
  const DropDownState({super.key});

  State<DropDownState> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownState> {
  String state = states.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: state,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        print(genero);
        // This is called when the user selects an item.
        setState(() {
          state = value!;
          estado = value;
        });
        print(estado);
        print(genero);
      },
      items: states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          alignment: Alignment.centerRight,
        );
      }).toList(),
    );
  }
}
