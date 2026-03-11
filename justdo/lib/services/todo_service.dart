import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:justdo/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
final String baseUrl = 'https://justdoserver-production.up.railway.app';

  // GET ALL TO DOS
  Future<List<Todo>> fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      print("Token in fetchTodos: $token");
    } else {
      print("No token found in fetchTodos");
    }

    final response = await http.get(Uri.parse('$baseUrl/todo/list'), headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});
    if (response.statusCode == 201) {

      final data = jsonDecode(response.body);
      final List<dynamic> todosJson = data['todos'] ?? [];
      return todosJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  // ADD TO DO
  Future<Todo> addTodo(Todo todo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      print("Token in addTodo: $token");
    } else {
      print("No token found in addTodo");
    }
    final response = await http.post(
      Uri.parse('$baseUrl/todo/add'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({
        'title': todo.title,
      }),
    );
    if (response.statusCode == 201) {
      // Successfully added
      final data = jsonDecode(response.body);
      print("DEBUG DATA: $data");
      return Todo.fromJson(data['todo']); // Assuming the response contains a 'todo' field with the new todo data
    } else {
      throw Exception('Failed to add todo');
    }
  }

  // TOGGLE COMPLETED
  Future<Todo> toggleCompleted(String todoId) async {
        final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      print("Token in Toggle: $token");
    } else {
      print("No token found in toggle complete");
    }
    final response = await http.put(
      Uri.parse('$baseUrl/todo/complete'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({
        'todoId': todoId,
      }),
    );
    print("response status: ${response.statusCode}");
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Todo.fromJson(data['todo']);
    } else {
      throw Exception('Failed to update todo');
    }
  }

  // REMOVE TO DO
  Future<void> deleteTodo(String todoId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      print("Token in deleteTodo: $token");
    } else {
      print("No token found in deleteTodo");
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/todo/remove'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({
        'todoId': todoId,
      }),

    );
    if (response.statusCode != 201) {
      throw Exception('Failed to delete todo'); 
    }
    print("Success deleting: $todoId");
  }
}