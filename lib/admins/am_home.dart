import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rostro_app/admins/am_add_new_user.dart';
import 'package:rostro_app/admins/am_userlist.dart';
import '../models/userlogin.dart';
import '../utils/constant.dart';
import 'package:http/http.dart' as http;
import '../screens/all_patient_list.dart';
import '../utils/Glassmorphism.dart';
import '../screens/all_patient_list.dart';
import '../screens/patient_list.dart';

class AdminHome extends StatefulWidget {
  final String token;
  final String? firstname;
  final String? lastname;
  const AdminHome({super.key,  required this.token, this.firstname, this.lastname});
  @override
  State<AdminHome> createState() => _AdminHome();
}

class _AdminHome extends State<AdminHome> {
  var bg = './assets/images/bg6.gif';
  late String token;
  late Future<UserLogin?> futureUser;
  late String? fn;
  late String? ln;
   bool is_superuser = true;
  var patientPictures;
  @override
  void initState() {
    super.initState();
    token = widget.token;
    is_superuser= true;
    
    

    futureUser = fetchUserProfile(token);
  }

  int currentPage = 0;

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
        child: futureBuilder(),
      ),
    );
  }

  Widget homeView() {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10.0),
              Column(
                children: const [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome to Rostro, Admin',
                      // textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 50.0),
            Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      'Hello $fn $ln!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      width: 200,
                      height: 300,
                      child: Column(
                        children: [
                          const SizedBox(height: 50.0),
                          Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            width: double.infinity,
                            height: 50,
                            child: Glassmorphism(
                              blur: 20,
                              opacity: 0.1,
                              radius: 50.0,
                              child: TextButton(
                                  // child: const Text('My Patient List'),
                                  // Within the `FirstRoute` widget
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                PatientList(token: token!)));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    child: const Text(
                                      "My Patient List",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.0),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            width: double.infinity,
                            height: 50,
                            child: Glassmorphism(
                              blur: 20,
                              opacity: 0.1,
                              radius: 50.0,
                              child: TextButton(
                                  // child: const Text('All Patient List'),
                                  // Within the `FirstRoute` widget
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AllPatientList(token: token!),
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    child: const Text(
                                      "All Patient List",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.0),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            width: double.infinity,
                            height:50,
                            child: Glassmorphism(
                              blur: 20,
                              opacity: 0.1,
                              radius: 50.0,
                              child: TextButton(
                                  // child: const Text('All Patient List'),
                                  // Within the `FirstRoute` widget
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              UserList(token: token!,is_superuser: is_superuser),
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    child: const Text(
                                      "User List",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.0),
                                    ),
                                  )),
                            ),
                          ),
                       
                        ],
                      ),
                    )
                  ],
                ),
              
               
            ],
          ),
        ),
      ],
    );
  }

  Widget futureBuilder() {
    return Container(
      child: FutureBuilder<UserLogin?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fn = snapshot.data!.first_name;
            ln = snapshot.data!.last_name;
            return homeView();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<UserLogin?> fetchUserProfile(token) async {
    UserLogin? newUser;
    Uri myProfileUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myProfileUri = Uri.https(Constants.BASE_URL, '/api/user/me/');
    } else {
      myProfileUri = Uri.parse('${Constants.BASE_URL}/api/user/me/');
    }
    final response = await http.get(
      myProfileUri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    var data = response.body;
    token = data.substring(10, data.length - 2);
    if (response.statusCode == 200) {
      String responseString = response.body;
      newUser = albumFromJson(responseString);
      return newUser;
    } else {
      const snackbar = SnackBar(
          content: Text("No user found",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)));
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar); //throw Exception('Failed to load album');
    }
  }
}