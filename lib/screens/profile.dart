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
  
  void initState() {
    token = widget.token;
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        child: ListView(
          children: <Widget>[
              showProfile(),
            // cameraButtonSection(),
            // PatientListContainer(),
            //  AddNewPatientButton(),
          ],
         ),
      ),
      // bottomNavigationBar: NavigationBar(
      //   destinations: const [
      //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //     NavigationDestination(icon: Icon(Icons.list), label: 'Patient'),
      //     NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   onDestinationSelected: (int index){
      //     setState(() {
      //       currentPage = index;
      //     });
      //   },
      //   selectedIndex: currentPage,
      // ),
    );
  }

  Container showProfile() {  
    return Container(
          child: FutureBuilder(
          future: fetchUser(token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              http.Response resp = snapshot.data as http.Response;
              print('token inside profile: $token');
                print(resp.statusCode);
              if (resp.statusCode == 200) {
                  print('uns');
              
            
                var temp =  jsonDecode(resp.body);
                 print(temp.toString());
              }
           
             
            
               else if (resp.statusCode == 401) { print('no patient return');
    
                Future.delayed(Duration.zero, () {
                 
                });
              } else if (resp.statusCode == 403) {
               
                Future.delayed(Duration.zero, () {
                 
                });
              }
            }
            // } else if (snapshot.hasError) {
           
            //     print('to snack bar');
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text('${snapshot.error}'),
            //   ));
            // }
            return const Center(
              child: Text(''''''),
            );
          },
        ),
      );
        
  }

Future<http.Response?> fetchUser(token) async {
      var myProfileUri =  Uri.parse('${Constants.BASE_URL}/api/user/me/');
      print('come to fetch data');
      print(token);
    final res = await http.get(myProfileUri,
    headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token '+ token,
      },
    );
    print(res.body);
          print('end of fetch');
    return res;
  }
}
