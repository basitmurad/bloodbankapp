import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController {
  // Controllers for text fields
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Rx variables for form validation status
  var isValid = false.obs;

  // Function to handle form validation and submission
  void handleSignup() {
    if (formValidation()) {
      Get.snackbar('Success', 'Signup Successful');
    }
  }

  // Validation functions
  bool formValidation() {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (username.isEmpty) {
      Get.snackbar('Error', 'Please enter your username');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
