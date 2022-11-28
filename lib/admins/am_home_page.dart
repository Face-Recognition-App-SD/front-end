import 'package:flutter/material.dart';
import 'package:rostro_app/admins/am_home.dart';
import 'package:rostro_app/screens/Home.dart';
import 'package:rostro_app/screens/add_new_patient.dart';
import 'package:rostro_app/screens/face_compare.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../screens/patient_list.dart';
import '../screens/all_patient_list.dart';
import '../screens/profile.dart';

class AdminHomePage extends StatefulWidget {
  final String token;
  final String? firstname;
  final String? lastname;
  final bool? is_superuser;
  const AdminHomePage(
      {super.key, required this.token, this.firstname, this.lastname, this.is_superuser});

  @override
  State<AdminHomePage> createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {
  static String token = "";
  late bool? is_superuser;

  var patientPictures;
  var pages;
  void initState() {
    token = widget.token;
    is_superuser= widget.is_superuser;

    pages = [
      AdminHome(token: token),
      CompareFace(token: token),
      PatientList(token: token),
      Profile(token: token),
    ];
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.add_a_photo_outlined), label: 'Recognize'),
          NavigationDestination(
              icon: Icon(Icons.list), label: 'My Patient List'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: const Color(0x00ffffff),
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }

  Container welcomeContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: const ClipRRect(
        child: Text('tem'),
      ),
    );
  }


  Container patientListContainer() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('PatientList'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => PatientList(token: token)));
          },
        ));
  }

  Container addNewPatientButton() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Add New Patient'),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddNewPatient(token: token)));
          },
        ));
  }

  Container recognizePatient() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Find Patient'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => CompareFace(token: token)));
          },
        ));
  }
}
