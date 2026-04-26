import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Off-white light background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32.0),
              // Title
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A),
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'nama@email.com',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16.0),
                  filled: true,
                  fillColor: const Color(0xFFEBEBEB), // Light gray background
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
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    letterSpacing: 4.0,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFEBEBEB),
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
                      color: Colors.grey[600],
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
                      color: Color(0xFFCC0000), // Honda Red
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48.0),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Perform login action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE00024), // Vibrant Red
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 2,
                  shadowColor: const Color(0xFFE00024).withOpacity(0.5),
                ),
                child: const Text(
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
                    child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Atau masuk dengan',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),

              // Social Media Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(Icons.apple, Colors.black),
                  const SizedBox(width: 16.0),
                  // Menggunakan network image untuk logo Google (atau fallback text 'G')
                  _buildGoogleIcon(),
                  const SizedBox(width: 16.0),
                  _buildSocialButton(Icons.facebook, const Color(0xFF1877F2)),
                ],
              ),
              const SizedBox(height: 48.0),

              // Register Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Register
                    },
                    child: const Text(
                      'Daftar Sekarang',
                      style: TextStyle(
                        color: Color(0xFFCC0000), // Honda Red
                        fontWeight: FontWeight.bold,
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

  // Builder method for generic icons (Apple, Facebook)
  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Icon(icon, color: color, size: 32.0),
    );
  }

  // Builder method for Google Network Logo
  Widget _buildGoogleIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
          width: 26,
          height: 26,
          errorBuilder: (context, error, stackTrace) {
            // Fallback apabila network gagal
            return const Text(
              'G',
              style: TextStyle(
                color: Color(0xFFDB4437),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}
