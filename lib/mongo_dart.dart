// import 'dart:developer';
//
// import 'package:mongo_dart/mongo_dart.dart';
//
// import 'Constants.dart';
//
// class MongoDatabase{
// static connect() async {
//   var db = await Db.create(Url);
//   await db.open();
//   inspect(db);
//
//   var status = db.serverStatus();
//   print(status);
//
//   var collection = db.collection(collecitionName);
//
//   print(await collection.find().toList());
// }
//
// }

import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;

Future<bool> checkUserAuthentication() async {
  try {
    final response = await http.get(
      Uri.parse('mongodb+srv://ehtishamzahid039:seDKcQ2jaFpRcGvl@cluster0.6l5q5.mongodb.net/'),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'}, // Optional, depending on how you handle auth
    );

    if (response.statusCode == 200) {
      // If the server responds with a 200 status code, the user is authenticated
      return true;
    } else {
      // If the status code is anything other than 200, the user is not authenticated
      return false;
    }
  } catch (e) {
    // Handle errors (e.g., network issues)
    return false;
  }
}

// Constants for MongoDB
const String Url = "mongodb+srv://ehtishamzahid039:seDKcQ2jaFpRcGvl@cluster0.6l5q5.mongodb.net/";
const String collectionName = "users";

class MongoDatabase {
  static late Db db;
  static late DbCollection collection;

  // Connect to MongoDB
  static connect() async {
    db = await Db.create(Url);
    await db.open();
    inspect(db);

    collection = db.collection(collectionName);
    print("Connected to MongoDB and Collection Initialized");
  }

  // Create a new user
  static Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      if (collection == null) {
        throw Exception("Database not connected");
      }

      // Insert user data into the collection
      await collection.insert(userData);

      print("User created successfully!");
    } catch (e) {
      print("An error occurred while creating the user: $e");
    }
  }

  Future<bool> checkUserAuthentication() async {
    try {
      final response = await http.get(
        Uri.parse('https://your-backend-api.com/check-auth'),
        headers: {'Authorization': 'Bearer YOUR_TOKEN'}, // Optional, depending on how you handle auth
      );

      if (response.statusCode == 200) {
        // If the server responds with a 200 status code, the user is authenticated
        return true;
      } else {
        // If the status code is anything other than 200, the user is not authenticated
        return false;
      }
    } catch (e) {
      // Handle errors (e.g., network issues)
      return false;
    }
  }

// Check if user is authenticated (exists in the database)
  // static Future<bool> checkUserAuthentication(String email) async {
  //   try {
  //     if (collection == null) {
  //       throw Exception("Database not connected");
  //     }
  //
  //     // Find user by email (or any other unique field like username)
  //     var user = await collection.findOne(where.eq('email', email));
  //
  //     if (user != null) {
  //       print("User authenticated: $email");
  //       return true; // User exists in the database
  //     } else {
  //       print("User not found: $email");
  //       return false; // User not found
  //     }
  //   } catch (e) {
  //     print("Error checking user authentication: $e");
  //     return false; // Return false in case of any error
  //   }
  // }
}
