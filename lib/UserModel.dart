
// import 'package:get/get.dart';
//
// class UserModel {
//   // Fields to store user data
//   String username;
//   String email;
//   String phone;
//   String password;
//   String bloodGroup;
//   String age;
//   String currentAddress;
//   double latitude; // Added latitude field
//   double longitude; // Added longitude field
//   RxString selectedGender;
//
//   // Constructor to initialize the UserModel
//   UserModel({
//     required this.username,
//     required this.email,
//     required this.phone,
//     required this.password,
//     required this.bloodGroup,
//     required this.age,
//     required this.currentAddress,
//     required this.latitude,  // Initialize latitude
//     required this.longitude, // Initialize longitude
//     required this.selectedGender,
//   });
//
//   // Method to convert the model into a map (useful for serialization)
//   Map<String, dynamic> toMap() {
//     return {
//       'username': username,
//       'email': email,
//       'phone': phone,
//       'password': password,
//       'bloodGroup': bloodGroup,
//       'age': age,
//       'currentAddress': currentAddress,
//       'latitude': latitude,   // Added latitude to the map
//       'longitude': longitude, // Added longitude to the map
//       'gender': selectedGender.value,
//     };
//   }
//
//   // Method to initialize a UserModel from a map (useful for deserialization)
//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       username: map['username'],
//       email: map['email'],
//       phone: map['phone'],
//       password: map['password'],
//       bloodGroup: map['bloodGroup'],
//       age: map['age'],
//       currentAddress: map['currentAddress'],
//       latitude: map['latitude'],  // Get latitude from map
//       longitude: map['longitude'], // Get longitude from map
//       selectedGender: RxString(map['gender']),
//     );
//   }
//
//   // Method to check if all fields are valid (e.g., not empty)
//   bool validateFields() {
//     return username.isNotEmpty &&
//         email.isNotEmpty &&
//         phone.isNotEmpty &&
//         password.isNotEmpty &&
//         bloodGroup.isNotEmpty &&
//         age.isNotEmpty &&
//         currentAddress.isNotEmpty &&
//         latitude != 0.0 &&  // Ensure latitude is not zero (or any invalid value)
//         longitude != 0.0 && // Ensure longitude is not zero (or any invalid value)
//         selectedGender.isNotEmpty;
//   }
// }
import 'package:get/get.dart';

class UserModel {
  // Fields to store user data
  String username;
  String email;
  String phone;
  String password;
  String userID;


  // Constructor to initialize the UserModel
  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.userID,

  });

  // Method to convert the model into a map (useful for serialization)
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'userID': userID,

    };
  }

  // Method to initialize a UserModel from a map (useful for deserialization)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      userID: map['userID'],

    );
  }

  // Method to check if all fields are valid (e.g., not empty)
  bool validateFields() {
    return username.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        password.isNotEmpty &&
        userID.isNotEmpty ;

  }
}
