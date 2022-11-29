import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rostro_app/screens/firstpage.dart';
import 'package:rostro_app/screens/login_page.dart';
import '../utils/constant.dart';
import '../models/userlogin.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../utils/Glassmorphism.dart';

class Profile extends StatefulWidget {
  final String token;
  final bool? is_superuser;
  const Profile({super.key, required this.token, this.is_superuser});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  var bg = './assets/images/bg6.gif';
  late String token;
  late Future<UserLogin?> futureUser;
  late Map<String, dynamic> pictures;
  XFile userPicture = XFile('/assets/images/icon_sample.jpeg');

  late bool? is_superuser;

  @override
  void initState() {
    token = widget.token;
    getPic();
    super.initState();
    is_superuser = widget.is_superuser;
    futureUser = fetchUserProfile(token);
  }

  int currentPage = 0;
  String? email = "";
  String? firstName = "";
  String? lastName = "";
  String? role = "";
  String? gender = "";
  int? id = -1;
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  FirstPage()),
                );
              },
              child: const Icon(Icons.logout_rounded),
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
              email = snapshot.data!.email;
              firstName = snapshot.data!.first_name;
              lastName = snapshot.data!.last_name;
              role = snapshot.data!.role;
              gender = snapshot.data!.gender;
              id = snapshot.data!.id;

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

  Widget displayProfile() {
    String picturePath = "";
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      picturePath = userPicture.path;
    } else {
      picturePath = "${Constants.BASE_URL}${userPicture.path}";
    }
    var picProfile;
    if (is_superuser == true) {
      picProfile = AssetImage('/assets/images/icon_sample.jpeg');
    }
    else picProfile = NetworkImage(picturePath);
    return ListView(children: <Widget>[
      Container(
        height: 250,
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(255, 49, 74, 173),
          //     Color.fromARGB(255, 160, 162, 235)
          //   ],
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          //   stops: [0.5, 0.9],
          // ),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
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
                    backgroundImage: picProfile,
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
            SizedBox(height: 15.0),
            changePasswordButton(context)
          ],
        ),
      ),
    ]);
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
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Future<XFile> getPic() async{
    Uri getUserPicUri = Uri();
    if(Constants.BASE_URL == "api.rostro-authentication.com"){
      getUserPicUri = Uri.https("${Constants.BASE_URL}", "/api/user/get_selfimages/");
    }
    else{
      getUserPicUri = Uri.parse("${Constants.BASE_URL}/api/user/get_selfimages/");
    }
    var response = await http.get(getUserPicUri,
    headers: {HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token'});
    pictures = json.decode(response.body);
    userPicture = XFile(pictures['image_lists'][pictures['image_lists'].length-1]['image']);
    return userPicture;
  }
  Widget changePasswordButton(BuildContext context) {
    // return Container(
    //     margin: const EdgeInsets.only(top: 30.0),
    //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //     child: ElevatedButton(
    //         child: const Text('Change Password'),
    //         onPressed: () async {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => PasswordChange(token: token)));
    //         }));
    return Glassmorphism(
      blur: 20,
      opacity: 0.1,
      radius: 50.0,
      child: TextButton(
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: const Text(
            "Change Password",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
