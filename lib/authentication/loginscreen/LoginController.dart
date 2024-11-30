import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  // Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password Validation
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  // Simulate login (you can replace this with real authentication logic)
  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {

      Get.snackbar(
            'Error',
            'Enter valid email and password',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,  // Background color
            colorText: Colors.white,  // Text color
            margin: const EdgeInsets.all(20.0),  // Add margin outside the snackbar
            borderRadius: 10.0,  // Rounded corners
            padding: const EdgeInsets.all(16.0),  // Padding inside the snackbar content
             // Animation duration
          );
      return;
    }
    await Future.delayed(Duration(seconds: 2)); // Simulate network request
    Get.snackbar('Success', 'Login successful');
  }
}
