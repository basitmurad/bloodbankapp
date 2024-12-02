import 'package:bloodbankapp/authentication/Colors.dart';
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
      backgroundColor: Colors.white.withOpacity(0.8),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 32,
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  // Logic to request for the nearest donor
                  Get.to(const NearDonorScreen());
                },
                child: const Text(
                  'Request Donor',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity - 20, 30),
                  // Sets width to fill and height to 50
                  padding: const EdgeInsets.all(8),

                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 32,
              width: 120,
              child: ElevatedButton(
                onPressed: () {


                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Make the height customizable

                      builder: (BuildContext context)
                  {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height

                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Become a Blood Donor',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                                'Please provide the following details to donate blood:'),
                            const SizedBox(height: 16),
                            // Add form fields or other details here
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Age',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Blood Type',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Handle the submit logic here
                                Navigator.pop(context); // Close the bottom sheet
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Thank you for donating!')),
                                );
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    );
                  });



                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(30, 30),
                  // Sets width to fill and height to 50
                  padding: const EdgeInsets.all(8),

                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ), // Disable button if already a donor
                child: const Text(
                  'Become a Now',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Height of the AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(
              16,
            ), // Adjust the radius here
            bottomRight: Radius.circular(16), // Adjust the radius here
          ),
          child: AppBar(
            backgroundColor: ColorsApp.red,
            // Change the AppBar color
            elevation: 0,
            // Remove shadow
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),

            automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        // Wrap the body in a SingleChildScrollView for scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saving Lives, One Donation at a Time",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 600,
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  // Ensures the GridView doesn't take up more space than needed
                  physics: const NeverScrollableScrollPhysics(),
                  // Prevents nested scrolling behavior
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 16.0, // Horizontal space between items
                    mainAxisSpacing: 16.0, // Vertical space between items
                    childAspectRatio: 1.001, // Adjust the card aspect ratio
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
              ),
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
        color: ColorsApp.red1, // Background color
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
              child: const Text(
                "Contact",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 25),
                // Sets width to fill and height to 50
                foregroundColor: Colors.red,
                // Text color for the button
                backgroundColor: Colors.white,
                // Button background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 16), // Adjust padding if needed
              ),
            )
          ],
        ),
      ),
    );
  }
}
