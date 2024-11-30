import 'package:bloodbankapp/authentication/ImagesPath.dart';
import 'package:bloodbankapp/authentication/signupscreen/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginController.dart';

class LoginScreen extends StatelessWidget {
  // Instantiate the controller
  final LoginController loginController = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(  // This allows scrolling if the content overflows
        child: Padding(
          padding: const EdgeInsets.all(20.0),



          child: SizedBox(
            height: screenHeight ,
            child: Column(
              // Centering the column children
              crossAxisAlignment: CrossAxisAlignment.stretch,  // Center items horizontally
              children: [


                SizedBox(height: screenHeight * 0.1,),


                Text(
                  'Empowering Life, \nOne Donation at a Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: screenHeight * 0.1 ,),

                // Email Text Field

                Obx(() => TextField(
                  onChanged: (value) => loginController.email.value = value,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),




                    prefixIcon: const Icon(Icons.email),
                  ),
                )),

                const SizedBox(height: 20),


                Obx(() => TextField(
                  onChanged: (value) => loginController.password.value = value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),




                    prefixIcon: const Icon(Icons.email),
                  ),
                )),

                // Password Text Field
                const SizedBox(height: 30),


                SizedBox(height: screenHeight * 0.12 -53,),


                ElevatedButton(
                  onPressed: () {
                    loginController.login();
                  },
                  child: const Text('Login' ,style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,  // Button background color (you can customize it)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Set the border radius to 6
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Optional: Add padding for a better appearance
                  ),
                )

,
                // Login Button
                 SizedBox(height: screenHeight * 0.1),

                // Navigate to SignUp screen
                TextButton(
                  onPressed: () {
                    print('clock');
                    Get.to(() => SignupScreen());  // Navigate to signup screen
                    Get.snackbar('Info', 'Navigate to sign-up screen');
                  },
                  child: const Text('Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
