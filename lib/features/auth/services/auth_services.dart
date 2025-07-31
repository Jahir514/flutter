import 'dart:convert';

import 'package:personal_budget/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static const String _url = '$baseUrl/auth';

  //Method for Registration by email
  Future<String> emailRegister({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_url/register'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return data['token'];
    } else {
      throw Exception(data['message'] ?? 'Registration Failed');
    }
  }

  //Method for login by email
  Future<String> emailLogin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_url/login'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);

    //send response based on status code
    if (response.statusCode == 200 || response.statusCode == 201) {
      return data['token'];
    } else {
      throw Exception(data['message'] ?? 'Login failed');
    }
  }
}
