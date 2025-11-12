import 'package:flutter/material.dart';
import 'package:medicalapp/bookingpage.dart';
import 'package:medicalapp/bottamnavigationpage.dart';
import 'package:medicalapp/forgetpasswordpage.dart';
import 'package:medicalapp/homepage.dart';
import 'package:medicalapp/loginpage.dart';
import 'package:medicalapp/mybookings.dart';
import 'package:medicalapp/newpasswordpage.dart';
import 'package:medicalapp/packagedetailspage.dart';

import 'package:medicalapp/signuppage.dart';
import 'package:medicalapp/splashscreen.dart';
import 'package:medicalapp/wishlistpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      debugShowCheckedModeBanner: false,
      home: Bottamapppage(),
    );
  }
}
