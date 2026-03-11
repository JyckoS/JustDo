// A register screen with email, password, and confirm password fields, along with a register button.
// Use colors from constants/app_colors.dart for styling.

import 'package:flutter/material.dart';
import 'package:justdo/constants/app_colors.dart';

class RegisterConfirmPasswordTextField extends StatelessWidget {
  const RegisterConfirmPasswordTextField({
    super.key,
    required this.confirmPasswordController,
  });

  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: confirmPasswordController,
        style: TextStyle(color: AppColors.textColor),
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirm Password',
          hintStyle:                    TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(Icons.lock_outline,
              color: AppColors.secondaryColor),
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
