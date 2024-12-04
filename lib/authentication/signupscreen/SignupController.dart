// //
// // import 'package:bloodbankapp/authentication/dashboardscreen/DashboardScreen.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // import '../../UserModel.dart';
// //
// // class SignupController extends GetxController {
// //   // Define controllers for each text field
// //   var usernameController = TextEditingController();
// //   var emailController = TextEditingController();
// //   var phoneController = TextEditingController();
// //   var passwordController = TextEditingController();
// //
// //   // Gender selection
// //
// //   // Signup function
// //   void handleSignup() async {
// //     // Get values from text controllers
// //     String username = usernameController.text.trim();
// //     String email = emailController.text.trim();
// //     String phone = phoneController.text.trim();
// //     String password = passwordController.text.trim();
// //
// //     // Validation: Ensure none of the fields are empty
// //     if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty ) {
// //       Get.snackbar("Error", "Please fill in all fields", snackPosition: SnackPosition.BOTTOM);
// //       return;
// //     }
// //
// //     try {
// //       // Example: Firebase Authentication signup logic (if using Firebase)
// //       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //
// //       // After successful sign up, save additional user information to Firebase Realtime Database
// //       String userId = userCredential.user?.uid ?? "";
// //
// //       // Create a UserModel instance
// //       UserModel user = UserModel(
// //         username: username,
// //         email: email,
// //         phone: phone,
// //         password: password,
// //
// //
// //       );
// //
// //       // Convert UserModel to map for Firebase
// //       Map<String, dynamic> userMap = user.toMap();
// //
// //       // Create a reference to the Realtime Database
// //       DatabaseReference dbRef = FirebaseDatabase.instance.ref("users/$userId");
// //
// //       // Save user data to the Firebase Realtime Database
// //       await dbRef.set(userMap);
// //
// //       // Show success message
// //       Get.snackbar("Success", "Account created successfully", snackPosition: SnackPosition.BOTTOM);
// //
// //       // Navigate to Dashboard
// //       Get.to(() => DashboardScreen());
// //
// //     } on FirebaseAuthException catch (e) {
// //       // Handle any errors from Firebase
// //       Get.snackbar("Error", e.message ?? "An error occurred", snackPosition: SnackPosition.BOTTOM);
// //     }
// //   }
// // }
// import 'package:bloodbankapp/authentication/donationDetailScreen/AddDetailsScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../UserModel.dart';
// import '../dashboardscreen/DashboardScreen.dart';
//
// class SignupController extends GetxController {
//   // Define controllers for each text field
//   var usernameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//   var passwordController = TextEditingController();
//
//   // Signup function
//   void handleSignup() async {
//     // Get values from text controllers
//     String username = usernameController.text.trim();
//     String email = emailController.text.trim();
//     String phone = phoneController.text.trim();
//     String password = passwordController.text.trim();
//
//     // Validation: Ensure none of the fields are empty
//     if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
//       Get.snackbar("Error", "Please fill in all fields", snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     try {
//       // Firebase Authentication signup logic
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       // After successful signup, save additional user information to Firebase Realtime Database
//       String userId = userCredential.user?.uid ?? "";
//
//       // Create a UserModel instance
//       UserModel user = UserModel(
//         username: username,
//         email: email,
//         phone: phone,
//         password: password, userID: userId,
//       );
//
//       // Convert UserModel to map for Firebase
//       Map<String, dynamic> userMap = user.toMap();
//
//       // Create a reference to the Realtime Database
//       DatabaseReference dbRef = FirebaseDatabase.instance.ref("users/$userId");
//
//       // Save user data to the Firebase Realtime Database
//       await dbRef.set(userMap);
//
//       // Save isLoggedIn in SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool("isLoggedIn", true);
//
//       // Show success message
//       Get.snackbar("Success", "Account created successfully", snackPosition: SnackPosition.BOTTOM);
//
//       // Navigate to Dashboard
//       Get.to(() => AddDetailsScreen());
//     } on FirebaseAuthException catch (e) {
//       // Handle any errors from Firebase
//       Get.snackbar("Error", e.message ?? "An error occurred", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UserModel.dart';
import '../donationDetailScreen/AddDetailsScreen.dart';

class SignupController extends GetxController {
  // Define controllers for each text field
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  // Signup function
  void handleSignup() async {
    // Get values from text controllers
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    // Validation: Ensure none of the fields are empty
    if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true; // Show progress indicator

    try {
      // Firebase Authentication signup logic
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful signup, save additional user information to Firebase Realtime Database
      String userId = userCredential.user?.uid ?? "";

      // Create a UserModel instance
      UserModel user = UserModel(
        username: username,
        email: email,
        phone: phone,
        password: password, userID:userId,
      );

      // Convert UserModel to map for Firebase
      Map<String, dynamic> userMap = user.toMap();

      // Create a reference to the Realtime Database
      DatabaseReference dbRef = FirebaseDatabase.instance.ref("users/$userId");

      // Save user data to the Firebase Realtime Database
      await dbRef.set(userMap);

      // Save isLoggedIn in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);

      // Show success message
      Get.snackbar("Success", "Account created successfully", snackPosition: SnackPosition.BOTTOM);

      // Clear the text fields
      usernameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();

      // Navigate to AddDetailsScreen
      Get.offAll(() => AddDetailsScreen());

    } on FirebaseAuthException catch (e) {
      // Handle any errors from Firebase
      Get.snackbar("Error", e.message ?? "An error occurred", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Hide progress indicator
    }
  }
}
