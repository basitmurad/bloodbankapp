import 'package:bloodbankapp/authentication/loginscreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication/signupscreen/SignupScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp( // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }


}

