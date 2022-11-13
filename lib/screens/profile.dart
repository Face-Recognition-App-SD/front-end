import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/login_page.dart';
import 'package:rostro_app/screens/pwdchange.dart';

import '../utils/constant.dart';
import '../models/userlogin.dart';
import '../screens/login_page.dart';

class Profile extends StatefulWidget {
  final String token;
  const Profile({super.key, required this.token});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  var bg = './assets/images/bg.jpeg';
  late String token;
  // late UserLogin? currUser;
  late Future<UserLogin?> futureUser;

  @override
  void initState() {
    token = widget.token;
    super.initState();
    futureUser = fetchUserProfile(token);
  }

  int currentPage = 0;
  String? email = "";
  String? firstname = "";
  String? last_name = "";
  String? role = "";
  String? gender = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              child: const Icon(Icons.logout_rounded),
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<UserLogin?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              email = snapshot.data!.email;
              firstname = snapshot.data!.first_name;
              last_name = snapshot.data!.last_name;

              role = snapshot.data!.role;
              gender = snapshot.data!.gender;

              return DisplayProfile();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget DisplayProfile() {
    return ListView(children: <Widget>[
      Container(
        height: 250,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 49, 74, 173),
              Color.fromARGB(255, 160, 162, 235)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.5, 0.9],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                // CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 50, 181, 109),
                //   minRadius: 35.0,
                //   child: Icon(
                //     Icons.call,
                //     size: 30.0
                //   ),
                // ),
                CircleAvatar(
                  backgroundColor: Colors.white70,
                  minRadius: 60.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        AssetImage('assets/images/icon_sample.jpeg'),
                  ),
                ),
                // CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 50, 181, 109),
                //   minRadius: 35.0,
                //   child: Icon(
                //     Icons.message,
                //     size: 30.0
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$firstname $last_name ',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '$role',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text(
                'Email',
                style: TextStyle(
                  color: Color.fromARGB(255, 40, 8, 164),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '$email',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(),
            ListTile(
              title: const Text(
                'Role',
                style: TextStyle(
                  color: Color.fromARGB(255, 40, 8, 164),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '$role',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(),
            ListTile(
              title: const Text(
                'Gender',
                style: TextStyle(
                  color: Color.fromARGB(255, 40, 8, 164),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '$gender',
                style: TextStyle(fontSize: 18),
              ),
            ),
            changePasswordButton(context)
          ],
        ),
      ),
    ]);
  }

  Future<UserLogin?> fetchUserProfile(token) async {
    UserLogin? newuser;

    // var response = await http.get(
    var myProfileUri = Uri.https(Constants.BASE_URL, '/api/user/me/');
    //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),

    // Uri.parse('${Constants.BASE_URL}/api/user/me/'),
    final response = await http.get(
      myProfileUri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token ' + token,
      },
    );

    var data = response.body;
    token = data.substring(10, data.length - 2);
    if (response.statusCode == 200) {
      String responseString = response.body;
      newuser = albumFromJson(responseString);

      return newuser;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget changePasswordButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            child: const Text('Change Password'),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => pwdchange(token: token)));
            }));
  }
  // Future<http.Response?> fetchUser(token) async {
  //   var myProfileUri = Uri.parse('${Constants.BASE_URL}/api/user/me/');
  //   print('come to fetch data');
  //   print(token);
  //   final res = await http.get(
  //     myProfileUri,
  //     headers: {
  //       HttpHeaders.acceptHeader: 'application/json',
  //       HttpHeaders.authorizationHeader: 'Token ' + token,
  //     },
  //   );
  //   print(res.body);
  //   print('end of fetch');
  //   return res;
  // }
}
