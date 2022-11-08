import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostro_app/models/userlogin.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';

import '../utils/constant.dart';
import './homepage.dart';
import './regisnew.dart';
import 'dart:io';
//import 'loggedinpage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  
  var bg = './assets/images/bg.jpeg';
  bool _isLoading = false;
  late String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        child: ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            SubmitButtonSection(),
        //    signUpButtonSection(),
          ],
        ),
      ),
    );
  } //build
  
  Container headerSection() {
   
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Image.asset(
          './assets/images/logo.jpeg',
          height: 100,
          width: 90,
          fit: BoxFit.scaleDown,
        
        ));
    //background im
  }

  TextEditingController emailController =  TextEditingController();
    TextEditingController passwordController =  TextEditingController();
  TextEditingController first_nameController =  TextEditingController();
  TextEditingController last_nameController =  TextEditingController();
  TextEditingController department_idController = TextEditingController();
  
var genderController =  const  DropdownButtonExample(list: Constants.genderList);
   Widget rolesController =    DropdownButtonExample(list: Constants.roles);
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;



  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: 'Email',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
         const SizedBox(height: 20.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
        style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: 'Password',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
           const SizedBox(height: 20.0),
          TextFormField(
            controller: first_nameController,
            cursorColor: Colors.white,
      style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Frist name',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
           const SizedBox(height: 20.0),
          TextFormField(
            controller: last_nameController,
            cursorColor: Colors.white,
             style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Last name',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
      
           const SizedBox(height: 20.0),
          TextFormField(
            controller: department_idController,
            cursorColor: Colors.white,
             style: TextStyle(color: Colors.white70, fontSize: 13),
            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: 'Department ID',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
      
           const SizedBox(height: 20.0),
    
 DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: const Text(
            'Select Item',
            style: TextStyle(
              fontSize: 12,
              
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 30,
          buttonWidth: 220,
          itemHeight: 30,
        ),
      ),
          
        ]),
      ),
    );
  }

  Container SubmitButtonSection() {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;
            UserLogin? data = await fetchDataLogin(email, password);
            print('info after login');
                print(token);
            setState(() {});
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => Homepage(token: token)),
                (Route<dynamic> route) => false);
              
          },
        )

        //end of button
        );
  }

  

Future<UserLogin?> fetchDataLogin(String email, String password) async {
   var response = await http.post(
    //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
     Uri.parse('${Constants.BASE_URL}/api/user/token/'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: {
        "email": email,
        "password": password,

      });
      var jsonResponse = null;
  var data = response.body;
  token = data.substring(10, data.length-2);
  if (response.statusCode == 201) {
    String responseString = response.body;

     setState(() {
          _isLoading = false;
        });


      return albumFromJson(responseString);
    } else {
      return null;
    }
  }
}






class DropdownButtonExample extends StatefulWidget {
   final List<String>?  list;
   const DropdownButtonExample({super.key, required this.list});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  
  late List<String>  list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list ?? ['no value'];
  }

String dropdownValue = 'Choose one';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white70),
      underline: Container(
         padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 2,
        color: Color.fromARGB(179, 85, 150, 221),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


