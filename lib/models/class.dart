import 'dart:convert';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));
String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  String? first_name;
  String? email;
  //final String? lastname;
  // final int? phone;
  String? password;
  //final String? cpass;
  // final int? ssn;
  // final String? address;
  // final String? org;

  Album({
    required this.first_name,
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
      first_name: json['first_name'],
      email: json['email'],
      // lastname: json['lastname'],
      // phone: json['phone'],
      // password: json['password'],
      password: "",
      // cpass: json['cpass'],
      // ssn: json['ssn'],
      // address: json['address'],
      // org: json['org'],
    );
  }

  Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "email": email,
        "password": password,
      };
}
