// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? token;
  String errorMessage;

  LoginModel({ this.token, this.errorMessage = ''});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(token: json["token"], errorMessage: json["error"] ?? '');

  Map<String, dynamic> toJson() => {"token": token, "error": errorMessage};
}
class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
