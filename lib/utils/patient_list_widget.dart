import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/firstpage.dart';
import 'package:rostro_app/screens/homepage.dart';
import '../screens/patient_detail.dart';
//import 'package:flutter_auth_roleperm/screens/userdetailsscreen.dart';
import '../models/PatientsData.dart';
class PatientListWidget extends StatefulWidget {
  final List<PatientsData> patientList;
  final String token;

  const PatientListWidget({Key? key, required this.patientList, required this.token}) : super(key: key);

  @override
  State<PatientListWidget> createState() => _PatientListWidgetState();
}

class _PatientListWidgetState extends State<PatientListWidget> {
  late String token;
  late String id;
  void initState() {
    token = widget.token;
  
    // initCamera(widget.patients![0]);
  }

  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: widget.patientList.isEmpty ? 0 : widget.patientList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Card(
            color: Color.fromARGB(255, 184, 197, 244),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 190, 192, 251), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PatientDetail(token: token,id:widget.patientList[index].id.toString())),
                );
              },
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 48,
                  color: Color.fromARGB(255, 58, 54, 118),
                ),
                title: Text(
                  widget.patientList[index].id.toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromARGB(255, 74, 10, 184),
                  ),
                ),
                subtitle: Text(
                  widget.patientList[index].first_name.toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromARGB(255, 37, 37, 146),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}