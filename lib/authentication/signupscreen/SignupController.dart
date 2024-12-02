// import 'package:bloodbankapp/authentication/dashboardscreen/DashboardScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';  // For displaying error dialogs or snackbars
//
// class SignupController extends GetxController {
//   // Define controllers for each text field
//   var usernameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//   var passwordController = TextEditingController();
//
//
//   // Gender selection
//   var selectedGender = 'Male'.obs;
//
//   // Signup function
//   void handleSignup() async {
//     // Get values from text controllers
//     String username = usernameController.text.trim();
//     String email = emailController.text.trim();
//     String phone = phoneController.text.trim();
//     String password = passwordController.text.trim();
//
//
//     // Validation: Ensure none of the fields are empty
//     if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty ) {
//       Get.snackbar("Error", "Please fill in all fields", snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//     else{
//       Get.snackbar('Sign Up', 'Account created successfully');
//
//     }
//
//
//     try {
//       // Example: Firebase Authentication signup logic (if using Firebase)
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       // After successful sign up, you can save additional user information if needed
//       print('User created: ${userCredential.user?.email}');
//
//       // Optionally, you can add the user data to Firestore or any other database
//       String userId = userCredential.user?.uid ?? "";
//
//       // Create a reference to the Realtime Database
//       DatabaseReference dbRef =
//       FirebaseDatabase.instance.ref("users");
//
//       // Show success message
//       Get.snackbar("Success", "Account created successfully", snackPosition: SnackPosition.BOTTOM);
//
//       Get.to(() =>DashboardScreen());
//     } on FirebaseAuthException catch (e) {
//       // Handle any errors from Firebase
//       Get.snackbar("Error", e.message ?? "An error occurred", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
import 'package:bloodbankapp/authentication/dashboardscreen/DashboardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../UserModel.dart';

class SignupController extends GetxController {
  // Define controllers for each text field
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var bloodGroupController = TextEditingController();
  var ageController = TextEditingController();
  var currentAddressController = TextEditingController();

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
    String currentAddress = currentAddressController.text.trim();

    // Validation: Ensure none of the fields are empty
    if (username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty || bloodGroup.isEmpty || age.isEmpty || currentAddress.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      // Example: Firebase Authentication signup logic (if using Firebase)
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful sign up, save additional user information to Firebase Realtime Database
      String userId = userCredential.user?.uid ?? "";

      // Create a UserModel instance
      UserModel user = UserModel(
        username: username,
        email: email,
        phone: phone,
        password: password,
        bloodGroup: bloodGroup,
        age: age,
        currentAddress: currentAddress,
        latitude: 0.0, // You can fetch this from the user's location service if needed
        longitude: 0.0, // You can fetch this from the user's location service if needed
        selectedGender: RxString(selectedGender.value),
      );

      // Convert UserModel to map for Firebase
      Map<String, dynamic> userMap = user.toMap();

      // Create a reference to the Realtime Database
      DatabaseReference dbRef = FirebaseDatabase.instance.ref("users/$userId");

      // Save user data to the Firebase Realtime Database
      await dbRef.set(userMap);

      // Show success message
      Get.snackbar("Success", "Account created successfully", snackPosition: SnackPosition.BOTTOM);

      // Navigate to Dashboard
      Get.to(() => DashboardScreen());

    } on FirebaseAuthException catch (e) {
      // Handle any errors from Firebase
      Get.snackbar("Error", e.message ?? "An error occurred", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
