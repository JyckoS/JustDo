// A register screen with email, password, and confirm password fields, along with a register button.
// Use colors from constants/app_colors.dart for styling.

import 'package:flutter/material.dart';
import 'package:justdo/constants/app_colors.dart';

class RegisterPasswordTextField extends StatelessWidget {
  const RegisterPasswordTextField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: passwordController,
        style: TextStyle(color: AppColors.textColor),
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle:
              TextStyle(color: AppColors.textSecondary),
          prefixIcon:
              Icon(Icons.lock, color: AppColors.secondaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: AppColors.secondaryColor),
          ),
        ),
      ),
    );
  }
}
