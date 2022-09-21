import 'dart:convert';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));
String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  String? firstname;
  String? email;
  //final String? lastname;
  // final int? phone;
  String? password;
  //final String? cpass;
  // final int? ssn;
  // final String? address;
  // final String? org;

  Album({
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

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
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
