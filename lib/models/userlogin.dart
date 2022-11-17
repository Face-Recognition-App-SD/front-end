import 'dart:convert';

UserLogin albumFromJson(String str) => UserLogin.fromJson(json.decode(str));
String albumToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  String? email;
  String? first_name;
  String? last_name;
  //final String? lastname;
  int? department_id;
  String? password;
  String? gender;
  String? role;
  String? cpassword;
  //final String? cpass;
  // final int? ssn;
  // final String? address;
  // final String? org;

  UserLogin({
    this.email,
    this.first_name,
    this.last_name,
    this.department_id,
    this.gender,
    this.role,
    this.password,
    this.cpassword,
    // required this.cpass,
    // required this.ssn,
    // required this.address,
    // required this.org,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      department_id: json['department_id'],
      gender: json['gender'],
      role: json['role'],
      cpassword: json['cpassword'],
      // cpass: json['cpass'],
      // ssn: json['ssn'],
      // address: json['address'],
      // org: json['org'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "first_name": first_name,
        "last_name": last_name,
        "department_id": department_id,
        "gender": gender,
        "role": role,
        "cpassword": cpassword,
      };
}
