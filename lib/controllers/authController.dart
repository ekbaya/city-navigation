import 'dart:convert';

import 'package:city_navigation/models/AccountResponse.dart';
import 'package:city_navigation/models/LoginDTO.dart';
import 'package:city_navigation/models/LoginResponse.dart';
import 'package:http/http.dart' as http;

import 'package:city_navigation/constants/AppConfig.dart';
import 'package:city_navigation/models/RegistrationResponse.dart';
import 'package:city_navigation/models/UserDTO.dart';

class AuthController {
  static Future<RegistrationResponse> registerUser(UserDTO userDTO) async {
    final result = await http.post(
      Uri.parse(registerUrl),
      headers: {
        'Accept': 'Application/json',
        'Content-Type': 'Application/json'
      },
      body: userDTO.toMap(),
    );

    var convertDataToJson = jsonDecode(result.body);
    return RegistrationResponse.fromMap(convertDataToJson);
  }

  static Future<LoginResponse> loginUser(LoginDTO loginDTO) async {
    final result = await http.post(
      Uri.parse(loginUrl),
      headers: {
        'Accept': 'Application/json',
        'Content-Type': 'Application/json'
      },
      body: loginDTO.toMap(),
    );

    var convertDataToJson = jsonDecode(result.body);
    return LoginResponse.fromMap(convertDataToJson);
  }

  static Future<AccountResponse> getCurrentUser() async {
    final result = await http.get(
      Uri.parse(accountUrl),
      headers: {
        'Accept': 'Application/json',
        'Content-Type': 'Application/json',
        'Authorization': 'Bearer ' + "some token"
      },
    );

    var convertDataToJson = jsonDecode(result.body);
    return AccountResponse.fromMap(convertDataToJson);
  }
}
