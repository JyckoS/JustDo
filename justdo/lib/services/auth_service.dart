import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) return false;

    // Validate token with server
    final response = await http.get(
      Uri.parse('$baseUrl/validate-token'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Token expired, clear it
      await prefs.remove('token');
      return false;
    }
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