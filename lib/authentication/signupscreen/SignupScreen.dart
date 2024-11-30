import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SignupController.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Height of the AppBar
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), // Adjust the radius here
            bottomRight: Radius.circular(30), // Adjust the radius here
          ),
          child: AppBar(
            backgroundColor: Colors.red, // Change the AppBar color
            elevation: 0, // Remove shadow
            title: Text(
              'Rounded AppBar',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white), // Set the back button color to white
              onPressed: () {
                // Add your back button functionality here
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // To allow scrolling if content overflows
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Heading Text
              Text(
                'Create an Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Name Input
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Email Input
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Phone Number Input
              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Password Input
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Blood Group Input
              TextField(
                controller: controller.bloodGroupController,
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Age Input
              TextField(
                controller: controller.ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Gender Selection (Dropdown or Radio Buttons)
              DropdownButtonFormField<String>(
                value: controller.selectedGender.value,
                onChanged: (String? newValue) {
                  controller.selectedGender.value = newValue!;
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
              ),
              SizedBox(height: 30),

              // Sign Up Button
              ElevatedButton(
                onPressed: controller.handleSignup,
                child: Text('Sign Up' ,style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,  // Button background color (you can customize it)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Set the border radius to 6
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Optional: Add padding for a better appearance
                ),
              ),
              SizedBox(height: 20),

              // Terms and Conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'By signing up, you agree with ',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Add logic to navigate to the Terms and Conditions page or show a dialog.
                        print('Navigate to Terms and Conditions');
                      },
                      child: Text(
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
