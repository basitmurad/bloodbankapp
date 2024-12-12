
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening the dial pad
import 'package:geolocator/geolocator.dart'; // For calculating distance

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
  double? _distanceInMeters;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default to San Francisco
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setTargetLocationMarker();
    _logLatLongAndNumber();
  }

  void _logLatLongAndNumber() {
    print('Phone Number: ${widget.number}');
    print('Latitude: ${widget.lat}');
    print('Longitude: ${widget.long}');
  }

  // Function to open the dial pad
  void _makeCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: widget.number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();

    setState(() {
      _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
      _currentLocationMarker = Marker(
        markerId: const MarkerId('current_location'),
        position: _currentPosition!,
        infoWindow: const InfoWindow(title: 'Your Location'),
      );

      // If the map is ready, adjust the camera
      if (mapController != null) {
        _fitMarkers();
      }

      _calculateDistance();
    });
  }

  void _setTargetLocationMarker() {
    if (widget.lat.isNotEmpty && widget.long.isNotEmpty) {
      LatLng targetLocation = LatLng(double.parse(widget.lat), double.parse(widget.long));
      setState(() {
        _targetLocationMarker = Marker(
          markerId: const MarkerId('target_location'),
          position: targetLocation,
          infoWindow: const InfoWindow(title: 'Target Location'),
        );
      });
    }
  }

  void _calculateDistance() {
    if (_currentPosition != null && _targetLocationMarker != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        _targetLocationMarker!.position.latitude,
        _targetLocationMarker!.position.longitude,
      );

      setState(() {
        _distanceInMeters = distanceInMeters;
      });
    }
  }

  void _fitMarkers() {
    if (mapController != null && _currentPosition != null && _targetLocationMarker != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          _currentPosition!.latitude < double.parse(widget.lat)
              ? _currentPosition!.latitude
              : double.parse(widget.lat),
          _currentPosition!.longitude < double.parse(widget.long)
              ? _currentPosition!.longitude
              : double.parse(widget.long),
        ),
        northeast: LatLng(
          _currentPosition!.latitude > double.parse(widget.lat)
              ? _currentPosition!.latitude
              : double.parse(widget.lat),
          _currentPosition!.longitude > double.parse(widget.long)
              ? _currentPosition!.longitude
              : double.parse(widget.long),
        ),
      );

      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _fitMarkers();
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: _makeCall,
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
      body: Column(
        children: [
          if (_distanceInMeters != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Distance: ${(_distanceInMeters! / 1000).toStringAsFixed(2)} km',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),


          Text('Donor Number is ${widget.number}' ,style: TextStyle(color: Colors.black ,fontSize: 16 ,fontWeight: FontWeight.bold),),

          const SizedBox(height: 20,),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition,
              markers: {
                if (_currentLocationMarker != null) _currentLocationMarker!,
                if (_targetLocationMarker != null) _targetLocationMarker!,
              },
            ),
          ),
        ],
      ),
    );
  }
}
