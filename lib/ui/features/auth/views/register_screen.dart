import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final bool isSmallScreen = screenHeight < 680;

    final double spaceAfterTitle = isSmallScreen ? 24.0 : 56.0;
    final double spaceBeforeButton = isSmallScreen ? 20.0 : 48.0;
    final double spaceBeforeDivider = isSmallScreen ? 20.0 : 48.0;
    final double spaceBeforeLogin = isSmallScreen ? 20.0 : 48.0;
    final double dividerTextFontSize = isSmallScreen ? 12.0 : 14.0;
    final double dividerTextPadding = isSmallScreen ? 8.0 : 16.0;

    return Scaffold(
      backgroundColor: const Color(
        0xFFFAFAFA,
      ), // Off-white light background (apple standard grouped)
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 480.0, // Tablet and landscape optimization limit
              ),
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
                  SizedBox(height: spaceAfterTitle),

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
                  _buildTextField('Masukkan nama lengkap', controller: _nameController, icon: Icons.person_outline),
                  const SizedBox(height: 16.0),

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
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),

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
                    controller: _passwordController,
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
                    controller: _confirmPasswordController,
                    icon: Icons.lock_reset_outlined,
                    isVisible: _isConfirmPasswordVisible,
                    onToggle: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: spaceBeforeButton),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              if (_passwordController.text != _confirmPasswordController.text) {
                                await showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: const Text('Gagal'),
                                    content: const Text('Konfirmasi kata sandi tidak cocok.'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('OK'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              await ref.read(authNotifierProvider.notifier).register(
                                    _emailController.text.trim(),
                                    _passwordController.text,
                                    _nameController.text.trim(),
                                  );

                              if (context.mounted) {
                                final authStateAfter = ref.read(authNotifierProvider);
                                if (!authStateAfter.hasError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Pendaftaran berhasil! Selamat datang di Hondaku.'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  context.go('/home');
                                } else {
                                  final errorMsg = authStateAfter.error?.toString() ?? 'Gagal melakukan registrasi.';
                                  await showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: const Text('Gagal'),
                                      content: Text(errorMsg),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text('OK'),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC40000), // Vibrant Red
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                        elevation: 4, // Matching login shadow
                        shadowColor: const Color(0xFFC40000).withValues(alpha: 0.4),
                      ),
                      child: authState.isLoading
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
                  SizedBox(height: spaceBeforeDivider),

                  // Divider "Atau daftar dengan"
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: Color(0xFFE8E8E8), thickness: 1.5),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: dividerTextPadding),
                        child: Text(
                          'Atau daftar dengan',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: dividerTextFontSize,
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
                      _buildAssetSocialButton(
                        'assets/icons/facebook-logo.svg',
                        onTap: () async {
                          try {
                            await ref.read(authNotifierProvider.notifier).loginWithFacebook(isLoginMode: false);
                            if (context.mounted) {
                              final stateAfter = ref.read(authNotifierProvider);
                              if (!stateAfter.hasError) {
                                context.go('/home');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(stateAfter.error.toString())),
                                );
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 16.0),
                      _buildAssetSocialButton(
                        'assets/icons/goggle-logo.svg',
                        onTap: () async {
                          try {
                            await ref.read(authNotifierProvider.notifier).loginWithGoogle(isLoginMode: false);
                            if (context.mounted) {
                              final stateAfter = ref.read(authNotifierProvider);
                              if (!stateAfter.hasError) {
                                context.go('/home');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(stateAfter.error.toString())),
                                );
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 16.0),
                      _buildIconSocialButton(
                        Icons.phone_outlined,
                        color: const Color(0xFFC40000), // Honda Red
                        onTap: () {
                          context.push('/phone-login', extra: false);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spaceBeforeLogin),

                  // Login Text
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
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
                            color: Color(0xFFC40000), // Brighter red
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
        ),
      ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
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
          borderSide: const BorderSide(color: Color(0xFFC40000), width: 2.0),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String hint,
    TextEditingController? controller,
    required bool isVisible,
    required VoidCallback onToggle,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
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
          borderSide: const BorderSide(color: Color(0xFFC40000), width: 2.0),
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

  Widget _buildAssetSocialButton(String assetPath, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  Widget _buildIconSocialButton(IconData icon, {Color? color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          child: Icon(
            icon,
            color: color ?? Colors.black87,
            size: 24,
          ),
        ),
      ),
    );
  }
}
