import 'package:flutter/material.dart';

class NearDonorScreen extends StatelessWidget {
  const NearDonorScreen({super.key});

  @override
  Widget build(BuildContext context) {


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
