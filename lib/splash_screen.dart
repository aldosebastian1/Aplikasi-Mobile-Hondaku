import 'package:flutter/material.dart';
import 'main.dart'; // Using this for now to navigate to MyHomePage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Home Page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Center Logo
            Center(
              child: Text(
                'HONDAKU',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900, // Very bold font for logo
                  color: const Color(0xFFCC0000), // Honda Red color
                  letterSpacing: -1.5,
                ),
              ),
            ),
            // Bottom Text
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'THE POWER OF DREAMS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600, // Grayish text color
                    letterSpacing: 2.5, // Spaced out letters
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
