import 'package:flutter/material.dart';
import 'package:justdo/constants/app_colors.dart';

class LoginEmailTextField extends StatelessWidget {
  const LoginEmailTextField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: emailController,
                        style: TextStyle(color: AppColors.textColor),
    
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          labelStyle: TextStyle(color: AppColors.textColor),
          prefixIcon: Icon(Icons.email, color: AppColors.secondaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
        ),
      ),
    );
  }
}