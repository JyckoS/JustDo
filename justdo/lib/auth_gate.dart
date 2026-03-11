import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

    return FutureBuilder(future: SharedPreferences.getInstance(), builder: (context, snapshot) {
      if (snapshot.hasData) {
        final prefs = snapshot.data!;
        final token = prefs.getString('token');
        if (token != null && token.isNotEmpty) {
          // User is logged in
         Debug.log("user is logged in");
          todoController.loadTodo();
          authController.setLoggedIn(true);
          return HomeScreen();
        } 
        // User is not logged in
        return LoginScreen();
      } else {
        // User is not logged in
        return LoginScreen();
      }
    });
  }
}