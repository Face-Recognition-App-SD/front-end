import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';


//TO-DO: after view detail, user can edit, delete a patient



  // NetworkImage getImage(String pfimg) {
    Future <http.Response> deletePatient(String id, String token) async {
    //var response = await http.delete(Uri.https('${Constants.BASE_URL}','/api/patients/all/$id/'),
    var response = await http.delete(Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/'),
         
    ///api/patients/all/{id}/
    headers: 
    {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Token ' + token,
      },
     );
       print('token inside Delete Paitne $token');
     print(response.statusCode);
    if(response.statusCode == 204){
     
      print("Deleted");
      return response;
    
    }else{throw "Sorry! Unable to delete this post";}
  }
