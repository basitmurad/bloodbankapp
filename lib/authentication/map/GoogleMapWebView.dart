// // // // import 'package:flutter/material.dart';
// // // // import 'package:webview_flutter/webview_flutter.dart';
// // // // import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // // //
// // // // class GoogleMapWebView extends StatefulWidget {
// // // //   @override
// // // //   _GoogleMapWebViewState createState() => _GoogleMapWebViewState();
// // // // }
// // // //
// // // // class _GoogleMapWebViewState extends State<GoogleMapWebView> {
// // // //   late final WebViewController _controller;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     // Initialize the WebViewController
// // // //     _controller = WebViewController();
// // // //     _controller
// // // //       ..loadRequest(Uri.parse('https://www.google.com/maps/@35.9088983,74.3470165,13z?entry=ttu&g_ep=EgoyMDI0MTEyNC4xIKXMDSoASAFQAw%3D%3D'))
// // // //       ..setJavaScriptMode(JavaScriptMode.unrestricted);
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text('Google Map WebView'),
// // // //       ),
// // // //       body: WebViewWidget(controller: _controller),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:webview_flutter/webview_flutter.dart';
// // // import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // // import 'package:geolocator/geolocator.dart';
// // //
// // // class GoogleMapWebView extends StatefulWidget {
// // //   @override
// // //   _GoogleMapWebViewState createState() => _GoogleMapWebViewState();
// // // }
// // //
// // // class _GoogleMapWebViewState extends State<GoogleMapWebView> {
// // //   late final WebViewController _controller;
// // //   Position? _userPosition;
// // //
// // //   // Coordinates for Gilgit, Pakistan
// // //   final double gilgitLatitude = 35.9208;
// // //   final double gilgitLongitude = 74.3085;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initializeWebView();
// // //     _getUserLocation();
// // //   }
// // //
// // //   // Initialize WebViewController
// // //   void _initializeWebView() {
// // //     _controller = WebViewController();
// // //     _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
// // //   }
// // //
// // //   // Get the user's current location
// // //   Future<void> _getUserLocation() async {
// // //     try {
// // //       Position position = await Geolocator.getCurrentPosition(
// // //         desiredAccuracy: LocationAccuracy.high,
// // //       );
// // //       setState(() {
// // //         _userPosition = position;
// // //       });
// // //       _loadGoogleMaps();
// // //     } catch (e) {
// // //       print('Error fetching user location: $e');
// // //       // Fallback to Gilgit location
// // //       _loadGoogleMaps(useGilgit: true);
// // //     }
// // //   }
// // //
// // //   // Load Google Maps with the user's or Gilgit location
// // //   void _loadGoogleMaps({bool useGilgit = false}) {
// // //     final latitude = useGilgit ? gilgitLatitude : _userPosition?.latitude;
// // //     final longitude = useGilgit ? gilgitLongitude : _userPosition?.longitude;
// // //
// // //     if (latitude != null && longitude != null) {
// // //       final url =
// // //           'https://www.google.com/maps/@$latitude,$longitude,15z?entry=ttu&g_ep=EgoyMDI0MTEyNC4xIKXMDSoASAFQAw%3D%3D';
// // //       _controller.loadRequest(Uri.parse(url));
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Google Map WebView'),
// // //       ),
// // //       body: _userPosition == null
// // //           ? const Center(child: CircularProgressIndicator())
// // //           : WebViewWidget(controller: _controller),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // import 'package:geolocator/geolocator.dart';
// //
// // class GoogleMapWebView extends StatefulWidget {
// //   @override
// //   _GoogleMapWebViewState createState() => _GoogleMapWebViewState();
// // }
// //
// // class _GoogleMapWebViewState extends State<GoogleMapWebView> {
// //   late final WebViewController _controller;
// //   Position? _userPosition;
// //
// //   // Default coordinates for Gilgit
// //   final double gilgitLatitude = 35.9208;
// //   final double gilgitLongitude = 74.3085;
// //
// //   // Custom points (markers) to set on the map
// //   final List<Map<String, double>> markers = [
// //     {'lat': 35.9180, 'lng': 74.3089}, // Custom Point 1
// //     {'lat': 35.9195, 'lng': 74.3105}, // Custom Point 2
// //     {'lat': 35.9202, 'lng': 74.3120}, // Custom Point 3
// //     {'lat': 35.9210, 'lng': 74.3135}, // Custom Point 4
// //   ];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeWebView();
// //     _getUserLocation();
// //   }
// //
// //   // Initialize WebViewController
// //   void _initializeWebView() {
// //     _controller = WebViewController();
// //     _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
// //   }
// //
// //   // Get the user's current location
// //   Future<void> _getUserLocation() async {
// //     try {
// //       Position position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );
// //       setState(() {
// //         _userPosition = position;
// //       });
// //       _loadGoogleMaps();
// //     } catch (e) {
// //       print('Error fetching user location: $e');
// //       // Fallback to Gilgit coordinates
// //       _loadGoogleMaps(useGilgit: true);
// //     }
// //   }
// //
// //   // Load Google Maps with the user's location and custom markers
// //   void _loadGoogleMaps({bool useGilgit = false}) {
// //     final latitude = useGilgit
// //         ? gilgitLatitude
// //         : (_userPosition?.latitude ?? gilgitLatitude);
// //     final longitude = useGilgit
// //         ? gilgitLongitude
// //         : (_userPosition?.longitude ?? gilgitLongitude);
// //
// //     // Create a URL string to show the map with custom markers
// //     String url = 'https://www.google.com/maps/@$latitude,$longitude,15z?entry=ttu';
// //
// //     // Add custom markers (for each point)
// //     markers.forEach((marker) {
// //       final markerLat = marker['lat'];
// //       final markerLng = marker['lng'];
// //       url += '&markers=$markerLat,$markerLng';
// //     });
// //
// //     _controller.loadRequest(Uri.parse(url));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Google Map WebView'),
// //       ),
// //       body: _userPosition == null
// //           ? const Center(child: CircularProgressIndicator())
// //           : WebViewWidget(controller: _controller),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GoogleMapWebView extends StatefulWidget {
//   @override
//   _GoogleMapWebViewState createState() => _GoogleMapWebViewState();
// }
//
// class _GoogleMapWebViewState extends State<GoogleMapWebView> {
//   late WebViewController _controller;
//   Position? _userPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize WebView
//     _controller = WebViewController();
//     _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
//
//     // Get user's current location
//     _getUserLocation();
//   }
//
//   // Get the user's current location
//   Future<void> _getUserLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _userPosition = position;
//       });
//
//       // Once the position is fetched, load the map with user's coordinates
//       _loadGoogleMaps();
//     } catch (e) {
//       print('Error fetching user location: $e');
//     }
//   }
//
//   // Load Google Maps with the user's location and custom icon
//   void _loadGoogleMaps() {
//     if (_userPosition != null) {
//       final latitude = _userPosition!.latitude;
//       final longitude = _userPosition!.longitude;
//
//       // URL to load Google Maps centered on user's location, with a custom marker
//       final String customIconUrl = 'https://your-server.com/path-to-your-icon.png'; // Replace with your custom icon URL
//       final url =
//           'https://www.google.com/maps/@$latitude,$longitude,15z?marker=$latitude,$longitude&markerIcon=$customIconUrl';
//
//       // Load the map in WebView
//       _controller.loadRequest(Uri.parse(url));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Map WebView'),
//       ),
//       body: _userPosition == null
//           ? const Center(child: CircularProgressIndicator()) // Show loading until location is fetched
//           : WebViewWidget(controller: _controller), // Show WebView with map
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapWebView extends StatefulWidget {
  @override
  _GoogleMapWebViewState createState() => _GoogleMapWebViewState();
}

class _GoogleMapWebViewState extends State<GoogleMapWebView> {
  late WebViewController _controller;
  Position? _userPosition;

  @override
  void initState() {
    super.initState();
    // Initialize WebView
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    // Get user's current location
    _getUserLocation();
  }

  // Get the user's current location
  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _userPosition = position;
      });

      // Once the position is fetched, load the map with user's coordinates
      _loadGoogleMaps();
    } catch (e) {
      print('Error fetching user location: $e');
    }
  }

  // Load Google Maps with the user's location and custom icon
  void _loadGoogleMaps() {
    if (_userPosition != null) {
      final latitude = _userPosition!.latitude;
      final longitude = _userPosition!.longitude;

      // URL to load Google Maps centered on user's location, with a custom marker
      final String customIconUrl = 'https://your-server.com/path-to-your-icon.png'; // Replace with your custom icon URL
      final url =
          'https://www.google.com/maps/@$latitude,$longitude,15z?marker=$latitude,$longitude&markerIcon=$customIconUrl';

      // Load the map in WebView
      _controller.loadRequest(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map WebView'),
      ),
      body: _userPosition == null
          ? const Center(child: CircularProgressIndicator()) // Show loading until location is fetched
          : WebViewWidget(controller: _controller), // Show WebView with map
    );
  }
}
