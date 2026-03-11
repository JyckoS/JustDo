import 'dart:convert';

import 'package:http/http.dart' as http show post;

import '../util.dart';

class AuthService {
final String baseUrl = 'https://justdoserver-production.up.railway.app';
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> register(
      String email, String password) async {
        Debug.log("Registering start");
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
        Debug.log("Registering finish");
    Debug.log("Registration response: ${response.body}");
    return jsonDecode(response.body);
  }
}