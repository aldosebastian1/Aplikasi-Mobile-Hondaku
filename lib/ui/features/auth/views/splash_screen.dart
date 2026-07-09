import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Start fade-in animation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _isVisible = true);
    });

    // Navigate to Onboarding after 3 seconds to ensure smooth precaching
    // Navigate to Onboarding after 2.5 seconds - Industry Standard Sweet Spot
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      _startExitTransition();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache onboarding images to prevent stuttering
    for (int i = 1; i <= 3; i++) {
      precacheImage(AssetImage('assets/images/onboarding/onboarding$i.jpg'), context);
    }
    // Precache home hero banners for smooth transition
    for (int i = 1; i <= 3; i++) {
      precacheImage(AssetImage('assets/images/banners/home_hero$i.jpg'), context);
    }
  }

  void _startExitTransition() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;

    if (!mounted) return;

    if (hasCompletedOnboarding) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          context.go('/home');
        } else {
          context.go('/login');
        }
      } catch (e) {
        debugPrint("Firebase not initialized in Splash: $e");
        context.go('/login');
      }
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double logoFontSize = constraints.maxHeight < 450 ? 36.0 : 48.0;
              final double bottomPadding = constraints.maxHeight < 450 ? 24.0 : 48.0;
              final double bottomFontSize = constraints.maxHeight < 450 ? 12.0 : 14.0;

              return Stack(
                children: [
                  // Center Logo and Text (Adjusted for optical center)
                  Align(
                    alignment: const Alignment(0, -0.15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/logos/logo.png',
                          height: constraints.maxHeight < 450 ? 130.0 : 180.0,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'HONDAKU',
                          style: TextStyle(
                            fontSize: logoFontSize,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFFC40000), // Honda Red
                            letterSpacing: -1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bottom Text
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      child: Text(
                        'THE POWER OF DREAMS',
                        style: TextStyle(
                          fontSize: bottomFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
