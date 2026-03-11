import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:justdo/controllers/auth_controller.dart';
import 'package:justdo/controllers/todo_controller.dart';
import 'package:justdo/views/home_screen.dart';
import 'package:justdo/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'util.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final todoController = Get.put(TodoController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: authController.checkToken(),
      builder: (context, snapshot) {
        // Show spinner while checking
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final isLoggedWithToken = snapshot.data ?? false;
        if (isLoggedWithToken) {
          todoController.loadTodo();
        }
        return isLoggedWithToken ? HomeScreen() : LoginScreen();
      },
    );
  }
}