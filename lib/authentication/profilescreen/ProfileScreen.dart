// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String name ='' ;  // Example user data
//   String email ='';
//   String phone ='';
//   String gender='';
//   // User's donor status
//
//    String? bloodGroup ;
//   void editProfile() {
//     // In a real app, you would show a form to edit the profile here
//     // For now, let's just update the name to demonstrate
//     setState(() {
//     });
//   }
//
//
//
//
//   Future<void> fetchUserDetails() async {
//     try {
//       // Get the current user ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Reference to the user's node in the Firebase Realtime Database
//       final DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users").child(userId);
//
//       // Fetch the data from Firebase Realtime Database
//       final DataSnapshot snapshot = await userRef.get();
//
//       // Check if the snapshot exists and has data
//       if (snapshot.exists) {
//         // Convert snapshot value to a Map
//         final Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);
//
//         // Extract specific fields (e.g., name and other details)
//
//
//          setState(() {
//            name = userData['username'] ?? 'No Name';
//            email = userData['email'] ?? 'No Email';
//          });
//         // Print or use the data as needed
//         print("Name: $name");
//         print("Email: $email");
//
//
//
//       } else {
//         print("No data available for the user.");
//       }
//     } catch (e) {
//       print("Error fetching user details: $e");
//     }
//   }
//   Future<void> fetchUserDetailsBlood() async {
//     try {
//       // Get the current user ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Reference to the user's node in the Firebase Realtime Database
//       final DatabaseReference userRef = FirebaseDatabase.instance.ref().child("donors").child(userId);
//
//       // Fetch the data from Firebase Realtime Database
//       final DataSnapshot snapshot = await userRef.get();
//
//       // Check if the snapshot exists and has data
//       if (snapshot.exists) {
//         // Convert snapshot value to a Map
//         final Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);
//
//         // Extract specific fields (e.g., name and other details)
//
//
//
//          setState(() {
//            bloodGroup = userData['bloodGroup'] ?? 'No ';
//            gender = userData['gender'] ?? 'No ';
//            phone = userData['phone'] ?? 'No ';
//          });
//          print("Your details are $phone  $gender   $bloodGroup");
//         // Print or use the data as needed
//
//       } else {
//         print("No data available for the user.");
//       }
//     } catch (e) {
//       print("Error fetching user details: $e");
//     }
//   }
//
// @override
//   void initState() {
//     super.initState();
//     fetchUserDetails();
//     fetchUserDetailsBlood();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//
//         preferredSize: const Size.fromHeight(60), // Height of the AppBar
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(16,), // Adjust the radius here
//             bottomRight: Radius.circular(16), // Adjust the radius here
//           ),
//           child: AppBar(
//             backgroundColor: Colors.red, // Change the AppBar color
//             elevation: 0, // Remove shadow
//             title: Text(
//               name,
//               style: const TextStyle(color: Colors.white),
//             ),
//             leading: IconButton(onPressed: (){
//               Get.back();
//
//             }, icon: const Icon(Icons.arrow_back ,color: Colors.white,)),
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Header
//             CircleAvatar(
//               radius: 40,
//               backgroundColor: Colors.red,
//               child: Text(
//                 (name.isNotEmpty ? name[0] : '?'),  // Display '?' if name is empty
//                 style: const TextStyle(fontSize: 40, color: Colors.white),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             Text('Email: $email', style: const TextStyle(fontSize: 18)),
//             Text('Phone: $phone', style: const TextStyle(fontSize: 18)),
//             Text('Phone: $bloodGroup', style: const TextStyle(fontSize: 18)),
//             Text('Phone: $gender', style: const TextStyle(fontSize: 18)),
//             // Text('Blood Group: $bloodGroup', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 20),
//             const SizedBox(height: 20),
//
//             // Donor Status
//             const SizedBox(height: 20),
//
//             // Profile Actions
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: editProfile,
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                   ),
//                   child: const Text('Delete Yourself from donor'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name ='' ;  // Example user data
  String email ='';
  String phone ='';
  String gender='';
  // User's donor status

  String? bloodGroup ;
  void editProfile() {
    // In a real app, you would show a form to edit the profile here
    // For now, let's just update the name to demonstrate
    setState(() {
    });
  }




  Future<void> fetchUserDetails() async {
    try {
      // Get the current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the user's node in the Firebase Realtime Database
      final DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users").child(userId);

      // Fetch the data from Firebase Realtime Database
      final DataSnapshot snapshot = await userRef.get();

      // Check if the snapshot exists and has data
      if (snapshot.exists) {
        // Convert snapshot value to a Map
        final Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);

        // Extract specific fields (e.g., name and other details)


        setState(() {
          name = userData['username'] ?? 'No Name';
          email = userData['email'] ?? 'No Email';
        });
        // Print or use the data as needed
        print("Name: $name");
        print("Email: $email");



      } else {
        print("No data available for the user.");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }
  Future<void> fetchUserDetailsBlood() async {
    try {
      // Get the current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the user's node in the Firebase Realtime Database
      final DatabaseReference userRef = FirebaseDatabase.instance.ref().child("donors").child(userId);

      // Fetch the data from Firebase Realtime Database
      final DataSnapshot snapshot = await userRef.get();

      // Check if the snapshot exists and has data
      if (snapshot.exists) {
        // Convert snapshot value to a Map
        final Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);

        // Extract specific fields (e.g., name and other details)



        setState(() {
          bloodGroup = userData['bloodGroup'] ?? 'No ';
          gender = userData['gender'] ?? 'No ';
          phone = userData['phone'] ?? 'No ';
        });
        print("Your details are $phone  $gender   $bloodGroup");
        // Print or use the data as needed

      } else {
        print("No data available for the user.");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    fetchUserDetailsBlood();
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
            title: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
            leading: IconButton(onPressed: (){
              Get.back();

            }, icon: const Icon(Icons.arrow_back ,color: Colors.white,)),
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
                (name.isNotEmpty ? name[0] : '?'),  // Display '?' if name is empty
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            Text('Email: $email', style: const TextStyle(fontSize: 18)),
            Text('Phone: $phone', style: const TextStyle(fontSize: 18)),
            Text('Phone: $bloodGroup', style: const TextStyle(fontSize: 18)),
            Text('Phone: $gender', style: const TextStyle(fontSize: 18)),
            // Text('Blood Group: $bloodGroup', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const SizedBox(height: 20),

            // Donor Status
            const SizedBox(height: 20),

            // Profile Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: editProfile,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  ),
                  child: const Text('Delete Yourself from donor'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
