import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'register_screen.dart'; // Import to navigate to RegisterScreen
import '../core/hondaku_app.dart'; // Import to navigate to main app

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false; // State for loading animation

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFFAFAFA,
      ), // Off-white light background (apple standard grouped)
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ), // HIG: Generous 24pt edge margin
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                // Make the back icon optically align perfectly with left margin
                child: Transform.translate(
                  offset: const Offset(-12, 0),
                  child: IconButton(
                    iconSize: 22,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Title
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38.0, // Large Title
                  fontWeight: FontWeight
                      .w900, // Very heavy weight referencing the image
                  color: Color(0xFF1A1A1A), // Native black/dark grey
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 56.0),

              // Email Label
              const Text(
                'EMAIL',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4D4C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              // Email Input Field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukkan email',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16.0),
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8), // Light gray background
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // Password Label
              const Text(
                'KATA SANDI',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4D4C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              // Password Input Field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Masukkan kata sandi',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16.0),
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(
                        0xFF5A4D4C,
                      ).withValues(alpha: 0.8), // Matches label color hint
                      size: 22.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Forgot Password Text
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Forgot Password
                  },
                  child: const Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(
                      color: Color(
                        0xFFE00024,
                      ), // Matching the brighter red from the button
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Login Button
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        // SET Loading UI True
                        setState(() {
                          _isLoading = true;
                        });

                        // Simulate generic system lag/processing network request for login
                        await Future.delayed(const Duration(seconds: 2));

                        if (context.mounted) {
                          setState(() {
                            _isLoading = false;
                          });

                          if (_emailController.text == 'admin@gmail.com' &&
                              _passwordController.text == 'admin123') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HondakuApp(),
                              ),
                            );
                          } else {
                            // Show error message using Apple HIG standard (Cupertino Dialog)
                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text('Login Gagal'),
                                  content: const Text(
                                    'Email atau kata sandi yang Anda masukkan salah. Silakan coba lagi.',
                                  ),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE00024), // Vibrant Red
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ), // Fully rounded like the design
                  ),
                  elevation: 8, // Soft shadow
                  shadowColor: const Color(
                    0xFFE00024,
                  ).withValues(alpha: 0.5), // Red glow
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3.0,
                        ),
                      )
                    : const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 48.0),

              // Divider "Atau masuk dengan"
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Color(0xFFE8E8E8), thickness: 1.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Atau masuk dengan',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFFE8E8E8), thickness: 1.5),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Social Media Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAssetSocialButton('assets/icons/apple-logo.svg'),
                  const SizedBox(width: 16.0),
                  _buildAssetSocialButton('assets/icons/goggle-logo.svg'),
                  const SizedBox(width: 16.0),
                  _buildAssetSocialButton('assets/icons/facebook-logo.svg'),
                ],
              ),
              const SizedBox(height: 48.0),

              // Register Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar Sekarang',
                      style: TextStyle(
                        color: Color(0xFFE00024), // Brighter red
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  // Builder method for Asset Social Button
  Widget _buildAssetSocialButton(String assetPath) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            assetPath,
            height: 32,
            width: 32,
            fit: BoxFit.contain,
            placeholderBuilder: (BuildContext context) =>
                const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
