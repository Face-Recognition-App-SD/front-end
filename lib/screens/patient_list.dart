import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/models/PatientsData.dart';
import 'package:rostro_app/screens/homepage.dart';
import './add_new_patient.dart';
import '../utils/patient_list_widget.dart';
import '../utils/constant.dart';
import '../utils/Glassmorphism.dart';
import 'package:gap/gap.dart';

class PatientList extends StatefulWidget {
  final String token;

  const PatientList({super.key, required this.token});
  @override
  State<PatientList> createState() => _PatientList();
}

class _PatientList extends State<PatientList> {
  var bg = './assets/images/bg6.gif';
  late String token;
  late List<PatientsData> patients = [];
  @override
  void initState() {
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              showPatients(),
              Container(
                // padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.symmetric(horizontal: 0.05 * deviceWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Container(
                    //   // width: double.infinity,
                    //   padding: EdgeInsets.only(right: 13),
                    Expanded(
                      child: Glassmorphism(
                        blur: 20,
                        opacity: 0.1,
                        radius: 50,
                        child: TextButton(
                          // child: const Text('Back to HomePage'),
                          onPressed: () async {
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Homepage(token: token)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: const Text(
                              "Home",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ),
                    // Container(
                    // padding: EdgeInsets.only(left: 13),
                    Gap(15),
                    Expanded(
                      child: Glassmorphism(
                        blur: 20,
                        opacity: 0.1,
                        radius: 50,
                        child: TextButton(
                          // child: const Text('Add New Patient'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddNewPatient(token: token),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                        isFromAll: false,
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
          return const Center(
            child: Text(''''''),
          );
        },
      ),
    );
  }

  Future<http.Response?> fetchPatients(token) async {
    Uri myProfileUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myProfileUri = Uri.https(Constants.BASE_URL, '/api/patients/patientss/');
    } else {
      myProfileUri = Uri.parse('${Constants.BASE_URL}/api/patients/patientss/');
    }
    final res = await http.get(
      myProfileUri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    return res;
  }
}
