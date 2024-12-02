import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationService {
  // Method to request location permission and get the user's current location
  Future<void> requestLocationPermissionAndGetLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location', 'Please enable your location services', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Check location permission status
    LocationPermission permission = await Geolocator.checkPermission();

    // Request permission if denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permission is still denied, show a pop-up to ask for permission again
        _showPermissionDialog();
      }
    }

    // Request for permission to allow the app to access the location
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Fetch the user's current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // You can now use the location (latitude and longitude) in your app
      print('Current Location: ${position.latitude}, ${position.longitude}');
    }
  }

  // Method to show a dialog asking the user to allow permission
  void _showPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Location Permission Required"),
        content: Text(
            "This app needs location permissions to function properly. Please allow the permission in your device settings."),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog and re-ask for permission
              Get.back();
              requestLocationPermissionAndGetLocation();
            },
            child: Text("Ask Again"),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog
              Get.back();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
