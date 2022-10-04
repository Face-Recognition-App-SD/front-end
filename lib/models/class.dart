import 'dart:convert';

UserInfo albumFromJson(String str) => UserInfo.fromJson(json.decode(str));
String albumToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  String? firstname;
  String? email;
  //final String? lastname;
  // final int? phone;
  String? password;
  //final String? cpass;
  // final int? ssn;
  // final String? address;
  // final String? org;

  UserInfo({
    required this.firstname,
    required this.email,
    // required this.lastname,
    // required this.phone,
    required this.password,
    // required this.cpass,
    // required this.ssn,
    // required this.address,
    // required this.org,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstname: json['firstname'],
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
        "firstname": firstname,
        "email": email,
        "password": password,
      };
}
