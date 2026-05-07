import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/hondaku_app.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false; // State for loading animation

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
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      // Go back to login screen
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Title
              const Text(
                'Buat Akun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38.0, // Large Title
                  fontWeight: FontWeight.w900, // Very heavy weight
                  color: Color(0xFF1A1A1A), // Native black/dark grey
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 56.0),

              // Full Name Label
              const Text(
                'NAMA LENGKAP',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4D4C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildTextField('Masukkan nama lengkap', icon: Icons.person_outline),
              const SizedBox(height: 16.0),

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
              _buildTextField(
                'Masukkan alamat email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),

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
              _buildPasswordField(
                hint: 'Masukkan kata sandi (Min. 8 karakter)',
                icon: Icons.lock_outline,
                isVisible: _isPasswordVisible,
                onToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Confirm Password Label
              const Text(
                'KONFIRMASI KATA SANDI',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4D4C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildPasswordField(
                hint: 'Konfirmasi kata sandi Anda',
                icon: Icons.lock_reset_outlined,
                isVisible: _isConfirmPasswordVisible,
                onToggle: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 48.0),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          // Set loading state
                          setState(() {
                            _isLoading = true;
                          });

                          // Fake network register action time
                          await Future.delayed(const Duration(seconds: 2));

                          if (context.mounted) {
                            setState(() {
                              _isLoading = false;
                            });

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HondakuApp(),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE00024), // Vibrant Red
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    elevation: 4, // Matching login shadow
                    shadowColor: const Color(0xFFE00024).withValues(alpha: 0.4),
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
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 48.0),

              // Divider "Atau daftar dengan"
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Color(0xFFE8E8E8), thickness: 1.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Atau daftar dengan',
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

              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah memiliki akun? ',
                    style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to login screen
                    },
                    child: const Text(
                      'Masuk di sini',
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

  Widget _buildTextField(
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: const Color(0xFF5A4D4C).withValues(alpha: 0.6),
                size: 22,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFE8E8E8).withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Color(0xFFE00024), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    IconData? icon,
  }) {
    return TextField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: const Color(0xFF5A4D4C).withValues(alpha: 0.6),
                size: 22,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFE8E8E8).withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Color(0xFFE00024), width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(
              0xFF5A4D4C,
            ).withValues(alpha: 0.8),
            size: 20.0,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }

  Widget _buildAssetSocialButton(String assetPath) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: SvgPicture.asset(
            assetPath,
            height: 26,
            width: 26,
            fit: BoxFit.contain,
            placeholderBuilder: (BuildContext context) =>
                const Icon(Icons.broken_image, color: Colors.grey, size: 18),
          ),
        ),
      ),
    );
  }
}
