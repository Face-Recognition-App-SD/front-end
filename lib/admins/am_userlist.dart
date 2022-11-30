import 'dart:convert';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/admins/am_home.dart';
import 'package:rostro_app/admins/am_home_page.dart';
import 'package:rostro_app/models/PatientsData.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

import 'package:rostro_app/screens/Home.dart';
import 'package:rostro_app/screens/homepage.dart';

import '../screens/verify_patient.dart';
import '../utils/patient_list_widget.dart';
import '../utils/constant.dart';
import '../utils/Glassmorphism.dart';
import 'package:gap/gap.dart';
import '../models/userlogin.dart';
import '../utils/Glassmorphism.dart';

import "../admins/am_add_new_user.dart";
import "../admins/am_user_detail.dart";

class UserList extends StatefulWidget {
  final String token;
  final bool? is_superuser;

  const UserList({super.key, required this.token, this.is_superuser});
  @override
  State<UserList> createState() => _PatientList();
}

class _PatientList extends State<UserList> {
  var bg = './assets/images/bg1.gif';
  late String token;
  late List<UserLogin> users = [];
  bool _searchBoolean = false;
  late bool? is_superuser;
  @override
  void initState() {
 //   super.initState();
    token = widget.token;
    is_superuser = widget.is_superuser;
  }

  TextEditingController txtQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: !_searchBoolean ? Text("User List") : searchBox(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHome(
                        token: token,

                      )),
            );
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
                      builder: (_) => AddNewUser(
                            token: token,
                            is_superuser: is_superuser,
                          )),
                );
              },
              child: const Icon(
                Icons.person_add,
                color: Color.fromARGB(255, 251, 235, 232),
              ),
            ),
          ),
        ],
      ),
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
              showUsers(),
            ],
          ),
        ),
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
   //   onEditingComplete: showUsers,
    );
  }

  Container showUsers() {
    return Container(
      child: FutureBuilder(
        future: fetchUser(token, is_superuser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            http.Response resp = snapshot.data as http.Response;

            if (resp.statusCode == 200) {
              final jsonMap = jsonDecode(resp.body);

              users = (jsonMap as List)
                  .map((patientItem) => UserLogin.fromJson(patientItem))
                  .toList();

              return users.isNotEmpty
                  ? userListView(context)
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No User found',
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

  Widget userListView(context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: users.isEmpty ? 0 : users.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: GlassContainer(
            borderRadius: new BorderRadius.circular(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetail(
                      token: token,
                      id: users[index].id,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  users[index].id.toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.blueAccent,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      users[index].first_name.toString().toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text(" "),
                    Text(
                      users[index].last_name.toString().toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                trailing: verify(context, index),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget verify(context, index) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (Context) => VerifyPatient(
                token: token, id: users[index].id!, isSuperUser: true),
          ),
        );
      },
      child: const Text('Verify User'),
    );
  }

  Future<http.Response?> fetchUser(token, is_superuser) async {
    var text = txtQuery.text;
    Uri myProfileUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myProfileUri =
          Uri.https(Constants.BASE_URL, '/api/admin/users/?search=$text');
    } else {
      myProfileUri =
          Uri.parse('${Constants.BASE_URL}/api/admin/users/?search=$text');
    }
    var response;

    response = await http.get(myProfileUri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    //  response.body("is_superuser", is_superuser);

    return response;
  }
}
