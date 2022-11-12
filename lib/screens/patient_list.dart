import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/models/PatientsData.dart';
import 'package:rostro_app/screens/homepage.dart';
import './add_new_patient.dart';
import '../utils/patient_list_widget.dart';
import '../utils/constant.dart';
import '../utils/scroll.dart';

class PatientList extends StatefulWidget {
  final String token;

  const PatientList({super.key, required this.token});
  @override
  State<PatientList> createState() => _PatientList();
}

class _PatientList extends State<PatientList> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  late List<PatientsData> patients = [];
  @override
  void initState() {
    token = widget.token;
    // initCamera(widget.patients![0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
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
              //containers
              showPatients(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Back to HomePage'),
                    onPressed: () async {
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Homepage(token: token)));
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text('New Patient'),

                        onPressed: () async {
                          // Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddNewPatient(token: token)));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  Container showPatients() {
    return Container(
      child: FutureBuilder(
        future: fetchPatients(token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            http.Response resp = snapshot.data as http.Response;
            if (resp.statusCode == 200) {
              final jsonMap = jsonDecode(resp.body);
              patients = (jsonMap as List)
                  .map((patientItem) => PatientsData.fromJson(patientItem))
                  .toList();
              return patients.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: PatientListWidget(
                        token: token,
                        patientList: patients,
                      ))
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No Patient found',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.171875,
                            fontSize: 24.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    );
            } else if (resp.statusCode == 401) {

              Future.delayed(Duration.zero, () {});
            } else if (resp.statusCode == 403) {
              Future.delayed(Duration.zero, () {});
            }
          }
          // } else if (snapshot.hasError) {

          //     print('to snack bar');
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text('${snapshot.error}'),
          //   ));
          // }
          return const Center(
            child: Text(''''''),
          );
        },
      ),
    );
  }

  Future<http.Response?> fetchPatients(token) async {
    //var myProfileUri = Uri.https(Constants.BASE_URL, '/api/patients/patientss/');
    var myProfileUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/');
    final res = await http.get(
      myProfileUri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token ' + token,
      },
    );
    return res;
  }
}
