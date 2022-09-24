// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/class.dart';


//   @override
//   Future<Album?> getUserFromToken(String token) async {
   
//     var response = await http.get(
//     //  Uri.https('api.rostro-authentication.com', 'api/user/create/'),
//        Uri.http('10.32.237.1 10:8000', 'api/user/me/'),
//       headers: {
//            "Content-type": "application/json",
//            "Accept": "application/json",
//           "Authorization": "Bearer $token"
//     });
    
     
    
//   if (response.statusCode == 201) {
//     String responseString = response.body;
//     return albumFromJson(responseString);
//   } else {
//     return null;
//   }
// }
  

//   @override
//   Future<Album?> login(Album login) async {
//     var response = await http.post(

//        Uri.http('10.32.237.110:8000', 'api/user/me/'),
//       headers: {
//            "Content-type": "application/json",
//            "Accept": "application/json",
//           "Authorization": "Bearer $token"
//     });
    
        
        
        
//         body: {'email': login.email, 'password': login.password});

//     if (result.statusCode == 200) {
//       var jsonData = result.body;
//       print('login');
//       print(jsonData);
//       return loginResponseFromJson(jsonData);
//     } else {
//       return null;
//     }
//   }