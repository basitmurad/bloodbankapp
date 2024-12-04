import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SignupController.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: AppBar(
            backgroundColor: Colors.red,
            elevation: 0,
            title: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create an Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Name Input
              TextField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Email Input
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number Input
              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Password Input
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              // const SizedBox(height: 16),
              //
              // // Blood Group Input
              // TextField(
              //   controller: controller.bloodGroupController,
              //   decoration: const InputDecoration(
              //     labelText: 'Blood Group',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // const SizedBox(height: 16),
              //
              // // Age Input
              // TextField(
              //   controller: controller.ageController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     labelText: 'Age',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // const SizedBox(height: 16),
              //
              // // Gender Selection (Dropdown or Radio Buttons)
              // DropdownButtonFormField<String>(
              //   value: controller.selectedGender.value,
              //   onChanged: (String? newValue) {
              //     controller.selectedGender.value = newValue!;
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Gender',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: ['Male', 'Female', 'Other']
              //       .map((gender) => DropdownMenuItem<String>(
              //     value: gender,
              //     child: Text(gender),
              //   ))
              //       .toList(),
              // ),
              const SizedBox(height: 30),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  if (_validateForm()) {
                    // Show progress dialog before starting the signup process
                    Get.dialog(
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      barrierDismissible: false,  // Prevent dismissing the dialog by tapping outside
                    );

                    controller.handleSignup();

                    // Close the progress dialog after signup is complete
                    Get.back();
                  }

                  // if (_validateForm()) {
                  //   controller.handleSignup();
                  // }
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
              ),
              const SizedBox(height: 20),

              // Terms and Conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      'By signing up, you agree with ',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print('Navigate to Terms and Conditions');
                      },
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Form validation method
  bool _validateForm() {
    String email = controller.emailController.text.trim();
    String password = controller.passwordController.text.trim();

    if (email.isEmpty || !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }

    if (password.isEmpty || password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }

    return true;
  }
}