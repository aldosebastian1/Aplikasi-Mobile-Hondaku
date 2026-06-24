import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      precacheImage(AssetImage('assets/images/onboarding$i.png'), context);
    }
  }

  void _startExitTransition() {
    context.go('/onboarding');
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
                  // Center Logo
                  Center(
                    child: Text(
                      'HONDAKU',
                      style: TextStyle(
                        fontSize: logoFontSize,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFC40000), // Honda Red
                        letterSpacing: -1.5,
                      ),
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
