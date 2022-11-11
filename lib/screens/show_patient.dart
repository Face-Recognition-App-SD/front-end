import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rostro_app/screens/patient_list.dart';

import '../utils/constant.dart';
import '../screens/delete.dart';

class ShowPatient extends StatefulWidget {
  final String token;
  final Map<String, dynamic> details;
  final XFile picture;
  // final String? id;
  const ShowPatient(
      {super.key,
      required this.token,
      required this.details,
      required this.picture});

  @override
  State<ShowPatient> createState() => ShowPatientDetails();
}

class ShowPatientDetails extends State<ShowPatient> {
  var bg = './assets/images/bg.jpeg';
  late Map<String, dynamic> details = widget.details;
  late String token = widget.token;
  late String id = widget.details['id'].toString();
  late XFile picture = widget.picture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Patient Detail'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () { delete(id, token);
                 Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PatientList(token: token,)),
          );},
                child: const Icon(Icons.delete, color: Colors.red,),
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
          ), //background image
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                 pic(),
                //  delete(id, token),
                textData(),
              ],
            ),
          ),
        ));
  }

  Widget pic(){
    String picturePath = "${Constants.BASE_URL}${picture.path}";
    //String picturePath = picture.path;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, children: [
      Image.network(picturePath, fit: BoxFit.fill, width: 250),
      //Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
      const SizedBox(height: 24),
    ]);
  }
  delete(String id, String token) async {
    var rest = await deletePatient(id, token);
    print('inside delete');
    print(rest);
    setState(() {});
  }

  Widget textData() {
    print("kjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Text>[
        Text(
          "\t\tID: $id",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tFirst Name: $firstname",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tlast name: $lastname",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tAge: $age",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tDescription: $description",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tMedications List: $medlist",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tPhone Number: $phonenumber",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tDate of Birth: $birthdate",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tStreet: $street",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tCity: $city",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tZip Code: $zipcode",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tState: $state",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tState: $state",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tCreation: $creation",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tModified: $modified",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tGender: $gender",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tEmergency Contact Name: $emergencyName",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tEmergency Contact Phone Number: $emergencyPhone",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tRelationship: $relationship",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tIs in hospital: $isInHospital",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\tUser: $user\n\n",
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Text(
          "\t\NewPatient: $user\n\n",
        ),
        Text(
          "\t\Inhre: $user\n\n",
        ),
        Text(
          "\t\New infp: $user\n\n",
        ),
      ],
    );
  }
}