import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/models/PatientsData.dart';
import '../utils/patient_list_widget.dart';
import '../utils/constant.dart';
import 'package:rostro_app/models/PatientsData.dart';

import 'package:rostro_app/screens/Home.dart';
import 'package:rostro_app/screens/homepage.dart';
import '../screens/add_new_patient.dart';
import '../admins/am_home_page.dart';

class AllPatientList extends StatefulWidget {
  final String token;
  final bool? is_superuser;
  const AllPatientList({super.key, required this.token, this.is_superuser});
  @override
  State<AllPatientList> createState() => _AllPatientList();
}

class _AllPatientList extends State<AllPatientList> {
  var bg = './assets/images/bg1.gif';
  late String token;
  late List<PatientsData> patients = [];
  bool _searchBoolean = false;
  late bool? is_superuser;
  @override
  void initState() {
    token = widget.token;
    is_superuser = widget.is_superuser;
    print('is suprt $is_superuser');
  }

  TextEditingController txtQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !_searchBoolean ? Text("All Patient List") : searchBox(),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              if (is_superuser == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminHomePage(
                            token: token,
                          )),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage(
                            token: token,
                          )),
                );
              }
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _searchBoolean = true;
                  });
                }),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddNewPatient(
                              token: token,
                            )),
                  );
                },
                child: const Icon(
                  Icons.person_add,
                  color: Color.fromARGB(255, 251, 235, 232),
                ),
              ),
            ),
          ]),
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
                //containers
                showPatientList(),
              ],
            ),
          )),
    );
  }

  Container showPatientList() {
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
                        isFromAll: true,
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

  TextFormField searchBox() {
    return TextFormField(
      style: TextStyle(color: Color.fromARGB(255, 243, 240, 241)),
      controller: txtQuery,
      // onChanged: search,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(fontSize: 16.0, color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            txtQuery.text = '';
            //   search(txtQuery.text);
          },
        ),
      ),
      onEditingComplete: showPatientList,
    );
  }

  Future<http.Response?> fetchPatients(token) async {
    var text = txtQuery.text;
    Uri myProfileUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myProfileUri = Uri.https(Constants.BASE_URL, '/api/patients/all/');
    } else {
      myProfileUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/');
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
