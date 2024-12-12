import 'package:bloodbankapp/authentication/Colors.dart';
import 'package:bloodbankapp/authentication/neardonorscreen/NearDonorScreen.dart';
import 'package:bloodbankapp/authentication/signupscreen/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../donationDetailScreen/AddDetailsScreen.dart';
import '../donationDetailScreen/MyHomePage.dart';
import '../loginscreen/LoginScreen.dart';
import '../profilescreen/ProfileScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoggedIn = false;
  List<Map<String, String>> donors = [];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    fetchDonors(); // Fetch donor data when the screen loads

  }

  Future<void> fetchDonors() async {
    final DatabaseReference donorRef = FirebaseDatabase.instance.ref().child("donors");

    // Fetch the data from Firebase Realtime Database
    final snapshot = await donorRef.get();

    if (snapshot.exists) {
      // Parse the data and update the donor list
      final donorsData = snapshot.value as Map<dynamic, dynamic>;
      List<Map<String, String>> loadedDonors = [];
      donorsData.forEach((key, value) {
        loadedDonors.add({
          'name': value['name'] ?? 'Unknown',
          'bloodGroup': value['bloodGroup'] ?? 'Unknown',
          'gender': value['gender'] ?? 'Unknown',
          'phone': value['phone'] ?? 'Unknown',
          'latitude': value['latitude']?.toString() ?? 'Unknown', // Convert to String
          'longitude': value['longitude']?.toString() ?? 'Unknown', // Convert to String
        });
      });
      print("data is $loadedDonors");

      setState(() {
        donors = loadedDonors; // Update the state with the fetched data
      });
    } else {
      // Handle case where data doesn't exist
      Get.snackbar("Error", "No donor data found.");
    }
  }


  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool("isLoggedIn");

    if (loggedIn == null || !loggedIn) {
      // If not logged in, navigate to LoginScreen
      Get.offAll(() => LoginScreen());
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }}

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
          onPressed: () async {

            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null && isLoggedIn ==true)  {

              if (kDebugMode) {
                print("User is not null");
              }
              // User is authenticated
              Get.to(()=>  AddDetailsScreen());
            }
             else if(currentUser != null && isLoggedIn ==false){
              Get.to(()=>  LoginScreen());

            }

            else {
              // User not authenticated
              Get.snackbar(
                "Authentication Required",
                "Please log in to request a donor.",
                snackPosition: SnackPosition.BOTTOM,
              );

              Get.to(() =>SignupScreen());

            }

          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(30, 30),
            padding: const EdgeInsets.all(8),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Become a Donor',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
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
            SizedBox(
              height: 500,
              child: GridView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.001,
                ),
                itemCount: donors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the Google Map screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(lat: donors[index]['latitude']!, long: donors[index]['longitude']!, number: donors[index]['phone']!,)
                        ),
                      );
                    },
                    child: DonorCard(
                      name: donors[index]['name']!,
                      gender: donors[index]['gender']!,
                      bloodGroup: donors[index]['bloodGroup']!,
                    ),
                  );
                },
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
