import 'dart:async';

import 'package:finsta_mac/Login/LoginScreen.dart';
import 'package:finsta_mac/view/MembersScreen.dart';
import 'package:finsta_mac/view/UsepinScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isNavigating = false;
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() {
    if (_isNavigating) return; // Prevent duplicate navigation
    _isNavigating = true;
    Timer(const Duration(seconds: 1), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted){
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const UsePinScreen()),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        _isNavigating = false;
      }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_icon.png', height: 150.0), // Your logo image
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Optional: A loading spinner while transitioning
          ],
        ),
      ),
    );
  }
}
