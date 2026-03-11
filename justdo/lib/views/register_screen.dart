// A register screen with email, password, and confirm password fields, along with a register button.
// Use colors from constants/app_colors.dart for styling.
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:justdo/constants/app_colors.dart';
import 'package:justdo/controllers/auth_controller.dart';
import 'package:justdo/widgets/register_screen/register_confirm_password_text_field.dart';
import 'package:justdo/widgets/register_screen/register_password_text_field.dart';
import 'package:justdo/widgets/register_screen/register_email_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Back button top left
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 32,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please sign up to continue',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 24),
            // Email field
            RegisterEmailTextField(emailController: emailController),
            SizedBox(height: 16),
            // Password field
            RegisterPasswordTextField(passwordController: passwordController),
            SizedBox(height: 16),
            // Confirm Password field
            RegisterConfirmPasswordTextField(confirmPasswordController: confirmPasswordController),
            SizedBox(height: 24), 
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                String email = emailController.text.trim().toLowerCase();
                String password = passwordController.text.trim();
                String confirmPassword = confirmPasswordController.text.trim();
                if (password != confirmPassword) {
                  Get.snackbar('Error', 'Passwords do not match',
                      backgroundColor: AppColors.primaryColor,
                      colorText: AppColors.errorColor);
                  return;
                }
                
                // Call the register method from the controller
                authController.register(email, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Register',
                style:
                    TextStyle(fontSize: 16, color: AppColors.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
