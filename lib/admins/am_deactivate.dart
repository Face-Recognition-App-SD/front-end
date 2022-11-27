import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rostro_app/admins/am_home.dart';
import 'package:rostro_app/admins/am_home_page.dart';
import 'package:rostro_app/models/userlogin.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../utils/Glassmorphism.dart';
import '../utils/constant.dart';
import '../screens/Home.dart';
import '../screens/homepage.dart';
import 'dart:io';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:glassmorphism/glassmorphism.dart';

//import 'Register.dart';

//import 'loggedinpage.dart';

class AdminDeactivate extends StatefulWidget {
  final String token;
  final int id;
  const AdminDeactivate({super.key,  required this.token, required this.id});

  @override
  State<AdminDeactivate> createState() => _AdminDeactivate();
}

class _AdminDeactivate extends State<AdminDeactivate> {
  // var bg = './assets/images/bg2.jpeg';
  var bg = './assets/images/bg6.gif';
  bool _isLoading = false;
  late String token;
  bool _is_superuser = false;
 late int id;
  bool _passwordVisible = false;
   bool _active = true;

  void initState() {
    token = widget.token;
    id = widget.id;
  }
 

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
         Text( "Active:",
                          // textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
        Switch(
                value: _active,
                onChanged: (value) {
                  setState(() {
                    
                    _active = value;
                    token= widget.token;
                  print("toi day");
                     print(_active);
                             id: id;
                    fetchData(id,token, _active );
                  });
                 
           

                },
                splashRadius: 100,
                activeTrackColor: Color.fromARGB(255, 63, 205, 234),
                activeColor: Color.fromARGB(255, 63, 205, 234),
                inactiveThumbColor: Color.fromARGB(255, 238, 238, 220),
                inactiveTrackColor: Color.fromARGB(146, 238, 238, 220) ,
                
        ),
      ],
    );
  } //build

  
Future <UserLogin?> fetchData(int id, String token, bool val) async {
      Uri patchUri = Uri();
      print("inside fethc");
      print(id);
      print(val);
      if(Constants.BASE_URL == "api.rostro-authentication.com"){
        patchUri = Uri.https(Constants.BASE_URL,'/api/admin/user/setActive/');
        
      }
      else{
        patchUri = Uri.parse('${Constants.BASE_URL}/api/admin/user/setActive/');
      }
    var response = await http.put(patchUri,

    headers: 
    {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: {
          "id": id.toString(),
          "isActive": val.toString(),
      }
     );
       print ("di duoc");
       print(response.body);
       print(response.statusCode);
    if(response.statusCode > 199 && response.statusCode < 300){
    
      return albumFromJson(response.body);
    
    }else{throw "Sorry! Unable to delete this post";}
  }

 
}
