import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../donationDetailScreen/MyHomePage.dart';

class NearDonorScreen extends StatefulWidget {
  const NearDonorScreen({super.key});

  @override
  State<NearDonorScreen> createState() => _NearDonorScreenState();
}

class _NearDonorScreenState extends State<NearDonorScreen> {

  List<Map<String, String>> donors = [];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {







    return Scaffold(
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
              'Within reach',
              style: TextStyle(color: Colors.white),
            ),

            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
          ),
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [


              const Text("Saving Lives, One Donation at a Time" ,style: TextStyle( fontWeight: FontWeight.w500,fontSize: 18 ),),

              const SizedBox(height: 20,),
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



            ],
          ),
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
