import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:justdo/constants/app_colors.dart';
import 'package:justdo/services/auth_service.dart';
import 'package:justdo/views/home_screen.dart';
import 'package:justdo/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  // Add any authentication-related logic here, such as login, registration, etc.
  final AuthService _authService = AuthService();
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  void setLoggedIn(bool value) async {
    isLoggedIn.value = value;
    if (!value) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
    }
  }
  Future<bool> checkToken() async {
    bool token = await _authService.checkToken();
    if (token) {
      setLoggedIn(true);
    } else {
      setLoggedIn(false);
    }
    return token;
  }
  void logout() async {
    setLoggedIn(false);
    Get.offAll(LoginScreen());
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await _authService.login(email, password);
      if (response["message"] == "Login successful") {
        // REPLACE LATER
        String token = response['token'];
        print("Received token: $token");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        setLoggedIn(true);
        Get.to(HomeScreen());
      } else {
        Get.snackbar('Login Failed', response['message'], colorText: AppColors.textColor);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login', colorText: AppColors.textColor  );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await _authService.register(email, password);
      if (response['message'] == 'User registered successfully') {
        Get.snackbar('Registration Successful', 'You can now log in', colorText: AppColors.textColor );
      } else {
        Get.snackbar('Registration Failed', response['message'], colorText: AppColors.textColor);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during registration', colorText: AppColors.textColor);
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}