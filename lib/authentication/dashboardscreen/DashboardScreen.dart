import 'package:bloodbankapp/authentication/neardonorscreen/NearDonorScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../profilescreen/ProfileScreen.dart';

class DashboardScreen extends StatelessWidget {
  // Sample donor data
  final List<Map<String, String>> donors = [
    {
      'name': 'John Doe',
      'bloodGroup': 'O+',
      'gender': 'Male',
    },
    {
      'name': 'Jane Smith',
      'bloodGroup': 'A+',
      'gender': 'Female',
    },
    {
      'name': 'Sarah Lee',
      'bloodGroup': 'B+',
      'gender': 'Female',
    },
    {
      'name': 'Michael Green',
      'bloodGroup': 'AB+',
      'gender': 'Male',
    },
    {
      'name': 'Emily Davis',
      'bloodGroup': 'O-',
      'gender': 'Female',
    },
    {
      'name': 'David White',
      'bloodGroup': 'A-',
      'gender': 'Male',
    },
    {
      'name': 'Sarah Lee',
      'bloodGroup': 'B+',
      'gender': 'Female',
    },
    {
      'name': 'Michael Green',
      'bloodGroup': 'AB+',
      'gender': 'Male',
    },
    {
      'name': 'Emily Davis',
      'bloodGroup': 'O-',
      'gender': 'Female',
    },
    {
      'name': 'David White',
      'bloodGroup': 'A-',
      'gender': 'Male',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:             Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(

          onPressed: () {
            // Logic to request for the nearest donor
   Get.to(const NearDonorScreen());
          },
          child: const Text('Request Nearest Donor' ,style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,  // Button background color (you can customize it)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6), // Set the border radius to 6
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Optional: Add padding for a better appearance
          ),
        ),
      ),

      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(60), // Height of the AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16,), // Adjust the radius here
            bottomRight: Radius.circular(16), // Adjust the radius here
          ),
          child: AppBar(
            backgroundColor: Colors.red, // Change the AppBar color
            elevation: 0, // Remove shadow
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              // Profile button
              IconButton(
                icon: const Icon(Icons.account_circle, color: Colors.white),
                onPressed: () {
                  // Navigate to Profile Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
            centerTitle: true,
          ),
        ),
      ),

      body: SingleChildScrollView(  // Wrap the body in a SingleChildScrollView for scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text("Saving Lives, One Donation at a Time" ,style: TextStyle( fontWeight: FontWeight.w500,fontSize: 18 ),),

         const SizedBox(height: 20,),
            GridView.builder(
              shrinkWrap: true,  // Ensures the GridView doesn't take up more space than needed
              physics: const NeverScrollableScrollPhysics(),  // Prevents nested scrolling behavior
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Number of columns
                crossAxisSpacing: 16.0,  // Horizontal space between items
                mainAxisSpacing: 16.0,  // Vertical space between items
                childAspectRatio: 1.001,  // Adjust the card aspect ratio
              ),
              itemCount: donors.length,
              itemBuilder: (context, index) {
                return DonorCard(
                  name: donors[index]['name']!,
                  gender: donors[index]['gender']!,
                  bloodGroup: donors[index]['bloodGroup']!,
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


class DonorCard extends StatelessWidget {
  final String name;
  final String gender;
  final String bloodGroup;

  const DonorCard({
    Key? key,
    required this.name,
    required this.gender,
    required this.bloodGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set the card's width and height dynamically based on screen size
    double cardWidth = screenWidth * 0.4; // 40% of screen width
    double cardHeight = screenHeight * 0.1; // 20% of screen height

    return Container(
      width: cardWidth, // Dynamically set width
      height: cardHeight, // Dynamically set height
      decoration: BoxDecoration(
        color: Colors.red, // Background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the name
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color white for contrast
              ),
            ),
            const SizedBox(height: 8),
            // Display the gender
            Text(
              'Gender: $gender',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70, // Lighter text for gender
              ),
            ),
            const SizedBox(height: 10),
            // Display the blood group
            Text(
              'Blood Group: $bloodGroup',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70, // Lighter text for blood group
              ),
            ),


            ElevatedButton(
              onPressed: () {},
              child: const Text("Contact"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 30), // Sets width to fill and height to 50
                foregroundColor: Colors.red, // Text color for the button
                backgroundColor: Colors.white, // Button background color
                padding: const EdgeInsets.symmetric(horizontal: 16), // Adjust padding if needed
              ),
            )],
        ),
      ),
    );
  }
}
