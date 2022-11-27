import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/patient_list.dart';
import 'package:rostro_app/screens/verify_patient.dart';

import '../utils/constant.dart';
import '../screens/delete.dart';
import '../screens/edit_patient.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class ShowPatient extends StatefulWidget {
  final String token;
  final Map<String, dynamic> details;
  final XFile picture;
  final bool isFromAll;

  const ShowPatient(
      {super.key,
      required this.token,
      required this.details,
      required this.picture,
      required this.isFromAll});

  @override
  State<ShowPatient> createState() => ShowPatientDetails();
}

class ShowPatientDetails extends State<ShowPatient> {
  var bg = './assets/images/bg6.gif';
  late Map<String, dynamic> details = widget.details;
  late String token = widget.token;
  late int id = widget.details['id'];
  late XFile picture = widget.picture;
  late bool isFromAll = widget.isFromAll;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Patient Detail',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatientList(
                          token: token,
                        )),
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (!isFromAll) {
                    delete(id, token);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PatientList(
                                token: token,
                              )),
                    );
                  }
                },
                child: Visibility(
                  visible: !isFromAll,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (!isFromAll) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyPatient(token: token, id: id),
                      ),
                    );
                  }
                },
                child: Visibility(
                  visible: !isFromAll,
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color.fromARGB(255, 18, 1, 58),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (!isFromAll) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditPatient(token: token, details: details),
                      ),
                    );
                  }
                },
                child: Visibility(
                  visible: !isFromAll,
                  child: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 243, 236, 235),
                  ),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  pic(),
                  //  delete(id, token),
                  textData(),
                ],
              ),
            )));
  }

  Widget pic() {
    String picturePath = "";
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      picturePath = picture.path;
    } else {
      picturePath = "${Constants.BASE_URL}${picture.path}";
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(picturePath, fit: BoxFit.fill, width: 250),
          //Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
        ]);
  }

  delete(int id, String token) async {
    var rest = await deletePatient(id, token);
    setState(() {});
  }

  Widget textData() {
    int? id = details['id'];
    String? firstname = details['first_name'];
    String? lastname = details['last_name'];
    String? description = details['description'];
    String? medlist = details['med_list'];
    int? age = details['age'];
    String? phonenumber = details['phone_number'];
    String? birthdate = details['date_of_birth'];
    String? street = details['street_address'];
    String? city = details['city_address'];
    String? zipcode = details['zipcode_address'];
    String? state = details['state_address'];
    String? creation = details['creation_date'];
    String? modified = details['modified_date'];
    String? gender = details['gender'];
    String? emergencyName = details['emergency_contact_name'];
    String? emergencyPhone = details['emergency_phone_number'];
    String? relationship = details['relationship'];
    bool? isInHospital = details['is_in_hospital'];
    String? user = details['user'];

    return GlassContainer(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                // borderRadius: new BorderRadius.circular(10.0),
                // child: Padding(
                // padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                  "\t\tID: $id",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            // Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tFirst Name: $firstname",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tlast name: $lastname",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tAge: $age",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tDescription: $description",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tMedications List: $medlist",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tPhone Number: $phonenumber",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tDate of Birth: $birthdate",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tStreet: $street",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tCity: $city",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tZip Code: $zipcode",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tState: $state",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tCreation: $creation",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tModified: $modified",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tGender: $gender",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tEmergency Contact Name: $emergencyName",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tEmergency Contact Phone Number: $emergencyPhone",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tRelationship: $relationship",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: Text(
                  "\t\tIs in hospital: $isInHospital",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            Divider(),
          ],
        ));
  }
}
