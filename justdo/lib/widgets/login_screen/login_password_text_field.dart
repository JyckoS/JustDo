import 'package:flutter/material.dart';
import 'package:justdo/constants/app_colors.dart';

class LoginPasswordTextField extends StatelessWidget {
  const LoginPasswordTextField({
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
          hintStyle:  TextStyle(color: AppColors.textSecondary),
          
          prefixIcon: Icon(Icons.lock, color: AppColors.secondaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
        ),
      ),
    );
  }
}
