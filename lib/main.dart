import 'package:finsta_mac/Login/LoginScreen1.dart';
import 'package:finsta_mac/view/DashboardScreen.dart';
import 'package:finsta_mac/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBS Mac',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: const SplashScreen(),
    );
  }
}
