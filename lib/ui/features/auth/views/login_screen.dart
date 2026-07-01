import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:hondaku/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isPasswordVisible = false;

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
    final authState = ref.watch(authNotifierProvider);
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final bool isSmallScreen = screenHeight < 680;

    final double spaceAfterTitle = isSmallScreen ? 24.0 : 56.0;
    final double spaceBeforeButton = isSmallScreen ? 16.0 : 32.0;
    final double spaceBeforeDivider = isSmallScreen ? 20.0 : 48.0;
    final double spaceBeforeRegister = isSmallScreen ? 20.0 : 48.0;
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
                maxWidth: 480.0, // HIG / Responsive tablet layout constraint
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ), // HIG: Generous 24pt edge margin
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    SizedBox(height: spaceAfterTitle),

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
                        hintText: 'Masukkan alamat email',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: const Color(0xFF5A4D4C).withValues(alpha: 0.6),
                          size: 22,
                        ),
                        filled: true,
                        fillColor: const Color(
                          0xFFE8E8E8,
                        ).withValues(alpha: 0.5),
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
                          borderSide: const BorderSide(
                            color: Color(0xFFC40000),
                            width: 2.0,
                          ),
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
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: const Color(0xFF5A4D4C).withValues(alpha: 0.6),
                          size: 22,
                        ),
                        filled: true,
                        fillColor: const Color(
                          0xFFE8E8E8,
                        ).withValues(alpha: 0.5),
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
                          borderSide: const BorderSide(
                            color: Color(0xFFC40000),
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(
                              0xFF5A4D4C,
                            ).withValues(alpha: 0.8),
                            size: 20.0,
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
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context)!.forgotPassword),
                              content: const Text(
                                'Fitur pengaturan ulang kata sandi mandiri belum tersedia.\n\n'
                                'Silakan hubungi customer service kami atau kunjungi dealer resmi Honda terdekat untuk bantuan reset akun.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    AppLocalizations.of(context)!.close,
                                    style: const TextStyle(color: Color(0xFFC40000)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            color: Color(
                              0xFFC40000,
                            ), // Matching the brighter red from the button
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spaceBeforeButton),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: authState.isLoading
                            ? null
                            : () async {
                                await ref.read(authNotifierProvider.notifier).login(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    );
                                if (context.mounted) {
                                  final authStateAfter = ref.read(authNotifierProvider);
                                  if (!authStateAfter.hasError) {
                                    context.go('/home');
                                  } else {
                                    final errorMsg = authStateAfter.error?.toString() ??
                                        'Email atau kata sandi yang Anda masukkan salah. Silakan coba lagi.';
                                    await showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: Text(AppLocalizations.of(context)!.loginFailed),
                                          content: Text(errorMsg),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text(AppLocalizations.of(context)!.ok),
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
                          backgroundColor: const Color(
                            0xFFC40000,
                          ), // Vibrant Red
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                          elevation: 4, // Softer shadow
                          shadowColor: const Color(
                            0xFFC40000,
                          ).withValues(alpha: 0.4),
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
                                'Masuk',
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

                    // Divider "Atau masuk dengan"
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            thickness: 1.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dividerTextPadding,
                          ),
                          child: Text(
                            'Atau masuk dengan',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: dividerTextFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            thickness: 1.5,
                          ),
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
                              await ref.read(authNotifierProvider.notifier).loginWithFacebook(isLoginMode: true);
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
                              await ref.read(authNotifierProvider.notifier).loginWithGoogle(isLoginMode: true);
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
                            context.push('/phone-login', extra: true);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spaceBeforeRegister),

                    // Register Text
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/register');
                          },
                          child: const Text(
                            'Daftar Sekarang',
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

  // Builder method for Asset Social Button
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
