import 'package:flutter/material.dart';
import 'package:rostro_app/screens/Home.dart';
import 'package:rostro_app/screens/add_new_patient.dart';
import 'package:rostro_app/screens/face_compare.dart';
import './patient_list.dart';
import './get_patient_pictures.dart';
import './profile.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class Homepage extends StatefulWidget {
  final String token;
  final String? firstname;
  final String? lastname;
  const Homepage(
      {super.key, required this.token, this.firstname, this.lastname});

  @override
  State<Homepage> createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  static String token1 = "";

  var patientPictures;
  var pages;
  void initState() {
    token1 = widget.token;

    pages = [
      Home(token: token1, isSuperUser: false,),
      CompareFace(token: token1, isSuperUser: false,),
      PatientList(token: token1, is_superuser: false,),
      Profile(token: token1),
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

  Container cameraButtonSection() {
    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Add User Pictures'),
          onPressed: () {
            patientPictures = Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GetPatientPictures(token: token1)));
          },
        ));
  }

  Container patientListContainer() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('PatientList'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => PatientList(token: token1, is_superuser: false,)));
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
                    builder: (_) => AddNewPatient(token: token1, is_superuser: false,)));
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
                MaterialPageRoute(builder: (_) => CompareFace(token: token1, isSuperUser: false,)));
          },
        ));
  }
}
