import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Onboarding Screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
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
                padding: const EdgeInsets.only(
                  bottom: 48.0,
                ), // HIG: multiple of 8
                child: Text(
                  'THE POWER OF DREAMS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600, // Grayish text color
                    letterSpacing: 2.0, // HIG: balanced tracking
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
