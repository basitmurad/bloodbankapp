import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Colors.dart';
import '../dashboardscreen/DashboardScreen.dart';

  class AddDetailsScreen extends StatefulWidget {
    @override
    _AddDetailsScreenState createState() => _AddDetailsScreenState();
  }

  class _AddDetailsScreenState extends State<AddDetailsScreen> {
    final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final List<String> genders = ['Male', 'Female', 'Other'];
    String? selectedBloodGroup;
    String? selectedGender;
    late LatLng latLng;
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    bool loading = false; // Loading state

    Future<void> saveDetails() async {
      setState(() {
        loading = true; // Show progress indicator
      });

      try {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user logged in')),
          );
          setState(() {
            loading = false;
          });
          return;
        }

        final userName = nameController.text;
        final bloodGroup = selectedBloodGroup;
        final address = addressController.text;
        final phone = phoneController.text;
        final gender = selectedGender;
        Position? position = await getUserLocation();
        if (position == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to retrieve user location')),
          );
          setState(() {
            loading = false;
          });
          return;
        }

        final latitude = position.latitude;
        final longitude = position.longitude;

        // Validate if all fields are filled
        if (bloodGroup == null || address.isEmpty || phone.isEmpty || gender == null || userName.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill out all fields')),
          );
          setState(() {
            loading = false;
          });
          return;
        }

        final databaseRef = FirebaseDatabase.instance.ref('donors');
        final userId = currentUser.uid;

        // Prepare donor data
        final donorData = {
          'name': userName,
          'bloodGroup': bloodGroup,
          'address': address,
          'phone': phone,
          'gender': gender,
          'latitude': latitude,
          'longitude': longitude,
        };

        // Check if the user already exists
        final userSnapshot = await databaseRef.child(userId).get();
        if (userSnapshot.exists) {
          // Update existing donor data
          await databaseRef.child(userId).update(donorData);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Details updated successfully!')),
          );
        } else {
          // Create new donor data
          await databaseRef.child(userId).set(donorData);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Details saved successfully!')),
          );
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          loading = false; // Hide progress indicator
        });
      }
    }

    // Method to save data to Firebase Realtime Database
    // Future<void> saveDetails() async {
    //   setState(() {
    //     loading = true; // Show progress indicator
    //   });
    //
    //   try {
    //     final currentUser = FirebaseAuth.instance.currentUser;
    //
    //     if (currentUser == null) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('No user logged in')),
    //       );
    //       setState(() {
    //         loading = false;
    //       });
    //       return;
    //     }
    //
    //     final userName = nameController.text;
    //     final bloodGroup = selectedBloodGroup;
    //     final address = addressController.text;
    //     final phone = phoneController.text;
    //     final gender = selectedGender;
    //     Position? position = await getUserLocation();
    //     if (position != null) {
    //       print('User location: Latitude = ${position.latitude}, Longitude = ${position.longitude}');
    //     } else {
    //       print('Failed to retrieve user location.');
    //     }
    //
    //     // Validate if all fields are filled
    //     if (bloodGroup == null || address.isEmpty || phone.isEmpty || gender == null || userName.isEmpty) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Please fill out all fields')),
    //       );
    //       setState(() {
    //         loading = false;
    //       });
    //       return;
    //     }
    //
    //     final databaseRef = FirebaseDatabase.instance.ref('donors');
    //     final userId = currentUser.uid;
    //
    //     // Check if the user already exists
    //     final userSnapshot = await databaseRef.child(userId).get();
    //     if (userSnapshot.exists) {
    //       // Update existing donor data
    //       await databaseRef.child(userId).update({
    //         'name': userName,
    //         'bloodGroup': bloodGroup,
    //         'address': address,
    //         'phone': phone,
    //         'gender': gender,
    //       });
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Details updated successfully!')),
    //       );
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => DashboardScreen()),
    //       );
    //
    //
    //     } else {
    //       // Create new donor data
    //       await databaseRef.child(userId).set({
    //         'name': userName,
    //         'bloodGroup': bloodGroup,
    //         'address': address,
    //         'phone': phone,
    //         'gender': gender,
    //       });
    //
    //
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => DashboardScreen()),
    //       );
    //
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Details saved successfully!')),
    //       );
    //     }
    //   } catch (error) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Error: $error')),
    //     );
    //   } finally {
    //     setState(() {
    //       loading = false; // Hide progress indicator
    //     });
    //   }
    // }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserLocation();


  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
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
                'Your Detail',
                style: TextStyle(color: Colors.white),
              ),

            iconTheme: IconThemeData(color: Colors.white),
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Select Blood Group',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedBloodGroup,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  hint: Text('Choose Blood Group'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBloodGroup = newValue;
                    });
                  },
                  items: bloodGroups.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(
                  'Current Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: addressController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter your current address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: phoneController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Select Gender',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  hint: Text('Choose Gender'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  items: genders.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveDetails,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Future<Position?> getUserLocation() async {
      try {
        // Check if location services are enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw Exception('Location services are disabled. Please enable them.');
        }

        // Check location permissions
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            throw Exception('Location permissions are denied.');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          throw Exception(
              'Location permissions are permanently denied. Cannot request permissions.');
        }

        // Get the current location
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        return position;
      } catch (e) {
        print('Error getting user location: $e');
        return null;
      }
    }

    void fetchUserLocation() async {
      Position? position = await getUserLocation();
      if (position != null) {
        print('User location: Latitude = ${position.latitude}, Longitude = ${position.longitude}');
      } else {
        print('Failed to retrieve user location.');
      }
    }

  }
