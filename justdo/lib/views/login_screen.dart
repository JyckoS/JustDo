import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:justdo/constants/app_colors.dart';
import 'package:justdo/controllers/auth_controller.dart';
import 'package:justdo/controllers/todo_controller.dart';
import 'package:justdo/widgets/login_screen/login_password_text_field.dart';
import 'package:justdo/widgets/login_screen/login_email_text_field.dart';
import 'package:justdo/views/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 32,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please sign in to continue',
              style: TextStyle(fontSize: 16, color: AppColors.secondaryColor),
            ),
            SizedBox(height: 24),
            LoginEmailTextField(emailController: emailController),
            SizedBox(height: 16),
            LoginPasswordTextField(passwordController: passwordController),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                handleLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 64,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
              ),
            ),

            SizedBox(height: 24),

            // Register button?
            TextButton(
              onPressed: () {
                // Navigate to register screen
                Get.to(() => RegisterScreen());
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: AppColors.secondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleLogin() async {
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text.trim();
    await authController.login(email, password);
    todoController.loadTodo();
  }
}
