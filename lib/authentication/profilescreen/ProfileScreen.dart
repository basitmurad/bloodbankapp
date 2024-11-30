import 'package:bloodbankapp/authentication/loginscreen/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name = 'John Doe';  // Example user data
  String? email = 'john.doe@example.com';
  String? phone = '+123456789';
  bool isDonor = false;  // User's donor status
  final String username = 'John Doe';

  final String password = '********'; // In a real app, you should not display passwords like this.
  final String bloodGroup = 'O+';
  final String age = '30';
  // Handle donor registration
  void registerAsDonor() {
    setState(() {
      isDonor = true;
    });

    // You can also handle actual registration logic here, such as sending the data to a backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfully registered as a donor!')),
    );
  }

  // Handle editing user profile (name, phone, etc.)
  void editProfile() {
    // In a real app, you would show a form to edit the profile here
    // For now, let's just update the name to demonstrate
    setState(() {
      name = 'Updated User Name';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(60), // Height of the AppBar
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16,), // Adjust the radius here
            bottomRight: Radius.circular(16), // Adjust the radius here
          ),
          child: AppBar(
            backgroundColor: Colors.red, // Change the AppBar color
            elevation: 0, // Remove shadow
            title: Text(
              name!,
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(onPressed: (){
              Get.back();

            }, icon: Icon(Icons.arrow_back ,color: Colors.white,)),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child: Text(
                name![0],  // Initials of the user
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Text('Username: $username', style: TextStyle(fontSize: 18)),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            Text('Phone: $phone', style: TextStyle(fontSize: 18)),
            Text('Password: $password', style: TextStyle(fontSize: 18)),
            Text('Blood Group: $bloodGroup', style: TextStyle(fontSize: 18)),
            Text('Age: $age', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SizedBox(height: 20),

            // Donor Status
            Text(
              isDonor ? 'You are a registered donor!' : 'You are not a donor yet.',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            SizedBox(height: 20),

            // Profile Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: editProfile,
                  child: Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  ),
                ),
                ElevatedButton(
                  onPressed: isDonor ? null : registerAsDonor,  // Disable button if already a donor
                  child: Text(isDonor ? 'Registered as Donor' : 'Register as Donor'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
