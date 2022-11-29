import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../utils/constant.dart';

Future<http.Response> deletePatient(int id, String token) async {
  Uri deleteUri = Uri();
  if (Constants.BASE_URL == "api.rostro-authentication.com") {
    deleteUri = Uri.https(Constants.BASE_URL, '/api/patients/all/$id/');
  } else {
    deleteUri = Uri.parse('${Constants.BASE_URL}/api/patients/all/$id/');
  }
  var response = await http.delete(
    deleteUri,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    },
  );
  if (response.statusCode == 204) {
    return response;
  } else {
    throw "Sorry! Unable to delete this post";
  }
}
