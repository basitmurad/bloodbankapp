import 'package:bloodbankapp/authentication/dashboardscreen/DashboardScreen.dart';
import 'package:bloodbankapp/authentication/loginscreen/LoginScreen.dart';
import 'package:bloodbankapp/authentication/map/GoogleMapWebView.dart';
import 'package:bloodbankapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication/signupscreen/SignupScreen.dart';
import 'mongo_dart.dart';

Future<void> main() async {



  try{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase Connected Successfully!");

  }
  catch (e){
    print("Firebase Do not connected ! $e");


  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp( // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }


}

