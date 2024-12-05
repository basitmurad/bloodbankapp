//
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// import '../Colors.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.lat, required this.long, required this.number});
//
//    final String  lat ;
//   final String long;
//   final String number;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   GoogleMapController? mapController;
//   Location location = Location();
//   LatLng? _currentPosition;
//   Marker? _currentLocationMarker;
//
//
//
//   final CameraPosition _initialCameraPosition = const CameraPosition(
//     target: LatLng(37.7749, -122.4194), // Default to San Francisco
//     zoom: 14.4746,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//     _logLatLongAndNumber();
//   }
//   void _logLatLongAndNumber() {
//     print('Phone Number: ${widget.number}');
//     print('Latitude: ${widget.lat}');
//     print('Longitude: ${widget.long}');
//   }
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//
//     // Check if location service is enabled
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     // Check location permissions
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     // Get the current location
//     final locationData = await location.getLocation();
//
//     setState(() {
//       _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
//       _currentLocationMarker = Marker(
//         markerId: MarkerId('current_location'),
//         position: _currentPosition!,
//         infoWindow: InfoWindow(title: 'Your Location'),
//       );
//
//       // Move the camera to the current location
//       if (mapController != null) {
//         mapController!.animateCamera(
//           CameraUpdate.newLatLngZoom(_currentPosition!, 14.0),
//         );
//       }
//     });
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     if (_currentPosition != null) {
//       mapController!.animateCamera(
//         CameraUpdate.newLatLngZoom(_currentPosition!, 14.0),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: ColorsApp.red,
//
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),
//         title: const Text(
//           'Donor Location',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: _initialCameraPosition,
//         markers: _currentLocationMarker != null ? {_currentLocationMarker!} : {},
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this for opening dial pad

import '../Colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.lat, required this.long, required this.number});

  final String lat;
  final String long;
  final String number;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController? mapController;
  Location location = Location();
  LatLng? _currentPosition;
  Marker? _currentLocationMarker;
  Marker? _targetLocationMarker;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default to San Francisco
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _logLatLongAndNumber();
  }

  void _logLatLongAndNumber() {
    print('Phone Number: ${widget.number}');
    print('Latitude: ${widget.lat}');
    print('Longitude: ${widget.long}');
  }

  // Function to open dial pad with phone number
  void _makeCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: widget.number);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch ${phoneUri.toString()}';
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the current location
    final locationData = await location.getLocation();

    setState(() {
      _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
      _currentLocationMarker = Marker(
        markerId: MarkerId('current_location'),
        position: _currentPosition!,
        infoWindow: InfoWindow(title: 'Your Location'),
      );

      // Move the camera to the current location
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 14.0),
        );
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentPosition != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 14.0),
      );
    }

    // Set the target location marker using the passed lat and long
    if (widget.lat.isNotEmpty && widget.long.isNotEmpty) {
      LatLng targetLocation = LatLng(double.parse(widget.lat), double.parse(widget.long));
      setState(() {
        _targetLocationMarker = Marker(
          markerId: MarkerId('target_location'),
          position: targetLocation,
          infoWindow: InfoWindow(title: 'Target Location'),
        );

        // Move the camera to the target location
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(targetLocation, 14.0),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsApp.red,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: _makeCall, // Make the call when the icon is clicked
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        title: const Text(
          'Donor Location',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialCameraPosition,
        markers: {
          if (_currentLocationMarker != null) _currentLocationMarker!,
          if (_targetLocationMarker != null) _targetLocationMarker!,
        },
      ),
    );
  }
}