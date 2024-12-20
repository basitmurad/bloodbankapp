import 'package:flutter/material.dart';

class DonorDetailScreen extends StatelessWidget {


  // Receive the details through the constructor
  const DonorDetailScreen({
    Key? key,

  }) : super(key: key);

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
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white), // Set the back button color to white
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the name

            const SizedBox(height: 16),
            // Optionally, add a contact button or any other action button
            ElevatedButton(
              onPressed: () {
                // Add functionality to contact the donor or any other actions
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
              ),
              child: const Text('Contact Donor'),
            ),
          ],
        ),
      ),
    );
  }
}
