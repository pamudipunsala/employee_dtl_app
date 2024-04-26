import 'dart:async';
import 'package:employee_dtl_app/Pages/display_dtl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Create animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    // Start the animation
    _animationController.forward();

    // Navigate to the main screen after 3 seconds delay
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DisplayDetails(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            'Employee Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.singleDay().fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
