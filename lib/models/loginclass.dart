import 'dart:convert';

LoginModel modelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String logModeltoJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? username;
  String? email;
  String? password;

  LoginModel({
    required this.username,
    required this.email,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
