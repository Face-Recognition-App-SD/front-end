import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/userlogin.dart';
import '../utils/constant.dart';
import './patient_list.dart';
import 'package:http/http.dart' as http;
import '../screens/all_patient_list.dart';
import '../utils/Glassmorphism.dart';

class Home extends StatefulWidget {
  final String? token;
  final String? firstname;
  final String? lastname;
  const Home({super.key, this.token, this.firstname, this.lastname});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  var bg = './assets/images/bg1.gif';
  late String? token;
  late Future<UserLogin?> futureUser;
  late String? fn;
  late String? ln;
  var patientPictures;
  @override
  void initState() {
    token = widget.token;
    super.initState();

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
              const SizedBox(height: 30.0),
              Column(
                children: const [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome to Rostro',
                      // textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 50.0),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 50.0),
                  child: Image.asset(
                    './assets/images/logo.jpeg',
                    height: 150,
                    width: 200,
                    fit: BoxFit.fitWidth,
                  )),
              Container(
                height: 300,
                width: 300,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(55, 73, 108, 248),
                      Color.fromARGB(52, 163, 163, 172)
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 0.9],
                  ),
                  color: const Color.fromARGB(255, 188, 191, 196),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Text(
                      'Hello $fn $ln!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      width: 200,
                      height: 200,
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
                          const SizedBox(height: 30.0),
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
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
