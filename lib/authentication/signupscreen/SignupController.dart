// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class SignupController extends GetxController {
//   // Define controllers for each text field
//   var usernameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//   var passwordController = TextEditingController();
//   var bloodGroupController = TextEditingController();
//   var ageController = TextEditingController();
//
//   // Gender selection
//   var selectedGender = 'Male'.obs;
//
//   // Signup function
//   void handleSignup() {
//     // Logic for handling sign-up (e.g., validation, API call)
//     print('Sign up with:');
//     print('Username: ${usernameController.text}');
//     print('Email: ${emailController.text}');
//     print('Phone: ${phoneController.text}');
//     print('Blood Group: ${bloodGroupController.text}');
//     print('Age: ${ageController.text}');
//     print('Gender: $selectedGender');
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';  // For displaying error dialogs or snackbars

class SignupController extends GetxController {
  // Define controllers for each text field
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var bloodGroupController = TextEditingController();
  var ageController = TextEditingController();

  // Gender selection
  var selectedGender = 'Male'.obs;

  // Signup function
  void handleSignup() async {
    // Get values from text controllers
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String bloodGroup = bloodGroupController.text.trim();
    String age = ageController.text.trim();

    // Validation: Ensure none of the fields are empty
    if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty || bloodGroup.isEmpty || age.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    else{
      Get.snackbar('Sign Up', 'Account created successfully');

    }

    // Additional validation can go here (e.g., email format, password strength)
    //
    // try {
    //   // Example: Firebase Authentication signup logic (if using Firebase)
    //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //
    //   // After successful sign up, you can save additional user information if needed
    //   print('User created: ${userCredential.user?.email}');
    //
    //   // Optionally, you can add the user data to Firestore or any other database
    //
    //   // Show success message
    //   Get.snackbar("Success", "Account created successfully", snackPosition: SnackPosition.BOTTOM);
    // } on FirebaseAuthException catch (e) {
    //   // Handle any errors from Firebase
    //   Get.snackbar("Error", e.message ?? "An error occurred", snackPosition: SnackPosition.BOTTOM);
    // }
  }
}
