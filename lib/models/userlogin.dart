import 'dart:convert';

UserLogin albumFromJson(String str) => UserLogin.fromJson(json.decode(str));
String albumToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {

  String? email;
  //final String? lastname;
  // final int? phone;
  String? password;
  //final String? cpass;
  // final int? ssn;
  // final String? address;
  // final String? org;

  UserLogin({
    
    required this.email,
    // required this.lastname,
    // required this.phone,
    required this.password,
    // required this.cpass,
    // required this.ssn,
    // required this.address,
    // required this.org,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      
      email: json['email'],
      // lastname: json['lastname'],
      // phone: json['phone'],
      // password: json['password'],
      password: json['password'],
      // cpass: json['cpass'],
      // ssn: json['ssn'],
      // address: json['address'],
      // org: json['org'],
    );
  }

  Map<String, dynamic> toJson() => {
     
        "email": email,
        "password": password,
      };
}
