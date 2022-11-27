import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/admins/am_edit_user.dart';
import 'package:rostro_app/admins/am_userlist.dart';
import 'package:rostro_app/screens/firstpage.dart';
import 'package:rostro_app/screens/login_page.dart';
import 'package:rostro_app/screens/pwdchange.dart';
import '../utils/constant.dart';
import '../models/userlogin.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../utils/Glassmorphism.dart';
import '../admins/am_edit_user.dart';


class UserDetail extends StatefulWidget {
  final String token;
  final id;
  const UserDetail({super.key, required this.token, required this.id});

  @override
  State<UserDetail> createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {
  var bg = './assets/images/bg6.gif';
  late String token;
  late int? id;
  late Future<UserLogin?> futureUser;

  @override
  void initState() {
    super.initState();
    token = widget.token;
    id = widget.id;
    futureUser = fetchUserProfile(token, id);
  }

  int currentPage = 0;
  String? email = "";
  String? firstName = "";
  String? lastName = "";
  String? role = "";
  String? gender = "";
  bool? is_superuser = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
         Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  {
                    delete(id!, token);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UserList(
                                token: token,
                              )),
                    );
                  }
                },
              
              
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                
              ),
            ),

Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditUser(id: id, token: token, futureUser: futureUser),
                      ),
                    );
                  },
                
                
                  child: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 243, 236, 235),
                  ),
                
              ),
            ),

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bg), fit: BoxFit.cover),
        ),
        child: FutureBuilder<UserLogin?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              id = snapshot.data!.id;
              email = snapshot.data!.email;
              firstName = snapshot.data!.first_name;
              lastName = snapshot.data!.last_name;
              role = snapshot.data!.role;
              gender = snapshot.data!.gender;
              is_superuser = snapshot.data!.is_superuser;
            

              return displayProfile();
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
 delete(int id, String token) async {
    var rest = await deleteUser(id, token);
    setState(() {});
  }

  Widget displayProfile() {
    return ListView(children: <Widget>[
      Container(
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white70,
                  minRadius: 60.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        AssetImage('assets/images/icon_sample.jpeg'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$firstName $lastName ',
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
        const Divider(),
            Padding(
               padding: EdgeInsets.only(left: 20, right: 20),
              child: GlassContainer(
                borderRadius: new BorderRadius.circular(15.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: ListTile(
                    title: const Text(
                      'ID',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '$id',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
      Divider(),
      Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: GlassContainer(
                borderRadius: new BorderRadius.circular(15.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: ListTile(
                    title: const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '$email',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: GlassContainer(
                borderRadius: new BorderRadius.circular(15.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: ListTile(
                    title: const Text(
                      'Role',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '$role',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: GlassContainer(
                borderRadius: new BorderRadius.circular(15.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: ListTile(
                    title: const Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '$gender',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
      Padding(
               padding: EdgeInsets.only(top: 10),
              child: GlassContainer(
                borderRadius: new BorderRadius.circular(15.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: ListTile(
                    title: const Text(
                      'Is Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '$is_superuser',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
  
          ],
        ),
      ),
    ]);
  }

  Future<UserLogin?> fetchUserProfile(token, id) async {
    UserLogin? newUser;
    Uri myProfileUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      myProfileUri = Uri.https(Constants.BASE_URL, '/api/admin/users/$id/');
    } else {
      myProfileUri = Uri.parse('${Constants.BASE_URL}/api/admin/users/$id/');
    }
    final response = await http.get(
      myProfileUri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    var data = response.body;

    if (response.statusCode == 200) {
      String responseString = response.body;
      newUser = albumFromJson(responseString);

      return newUser;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user info');
    }
  }
Future <http.Response> deleteUser(int id, String token) async {
      Uri deleteUri = Uri();
      if(Constants.BASE_URL == "api.rostro-authentication.com"){
        deleteUri = Uri.https(Constants.BASE_URL,'/api/admin/users/$id/');
      }
      else{
        deleteUri = Uri.parse('${Constants.BASE_URL}/api/admin/users/$id/');
      }
    var response = await http.delete(deleteUri,

    headers: 
    {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
     );
    if(response.statusCode > 200 && response.statusCode < 300){
      setState(() {
        
      });
      return response;
    
    }else{throw "Sorry! Unable to delete this post";}
  }

 
}
