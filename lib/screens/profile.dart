import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../models/userlogin.dart';

class Profile extends StatefulWidget {
  final String? token;
  const Profile({super.key, this.token});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  var bg = './assets/images/bg.jpeg';
  late String? token;
  // late UserLogin? currUser;
  late Future<UserLogin?> futureUser;
  void initState() {
    token = widget.token;
    super.initState();
    futureUser = fetchUserProfile(token);
  }

  int currentPage = 0;
  String? email = "";
  String? firstname = "";
  String? last_name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Container(
        child: FutureBuilder<UserLogin?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              email = snapshot.data!.email;
              firstname = snapshot.data!.first_name;
              last_name = snapshot.data!.last_name;

              return ListView(children: <Widget>[
                Text('Welcome, $last_name',style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Color.fromARGB(255, 10, 3, 20),
                ),),

                Text('My fullname: $firstname $last_name',style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: Color.fromARGB(255, 37, 23, 57),
                ),),

                 Text('My email: $email',style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: Color.fromARGB(255, 37, 23, 57),
                ),),
               // DisplayProfile(context),
              ] //background image
                  );
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

  Widget DisplayProfile(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: Card(
          color: Color.fromARGB(255, 225, 227, 231),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color.fromARGB(255, 190, 192, 251), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            child: ListTile(
              leading: const Icon(
                Icons.person,
                size: 48,
                color: Color.fromARGB(255, 58, 54, 118),
              ),
              title: Text(
                email!,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromARGB(255, 207, 201, 216),
                ),
              ),
              subtitle: Text(
                firstname!,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromARGB(255, 222, 222, 236),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Center showProfile() {
  //   return Center(
  //     child: FutureBuilder<UserLogin?>(
  //       future: futureUser,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           String? temp = snapshot.data!.email;
  //           return Text(temp!);
  //         } else if (snapshot.hasError) {
  //           return Text('${snapshot.error}');
  //         }

  //         // By default, show a loading spinner.
  //         return const CircularProgressIndicator();
  //       },
  //     ),
  //   );
  // }

  Future<UserLogin?> fetchUserProfile(token) async {
    UserLogin? newuser;
    var response = await http.get(
      //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
      Uri.parse('${Constants.BASE_URL}/api/user/me/'),
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
