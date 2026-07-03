import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:hondaku/l10n/app_localizations.dart';
import '../../../core/widgets/hondaku_toast.dart';
import '../widgets/auth_input_fields.dart';
import '../widgets/auth_social_buttons.dart';

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
                    AuthTextField(
                      hint: 'Masukkan alamat email',
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
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
                    AuthPasswordField(
                      hint: 'Masukkan kata sandi',
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
                                    HondakuToast.showError(context, errorMsg);
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
                        AuthSocialButton(
                          assetPath: 'assets/icons/facebook-logo.svg',
                          onTap: () async {
                            try {
                              await ref.read(authNotifierProvider.notifier).loginWithFacebook(isLoginMode: true);
                              if (context.mounted) {
                                final stateAfter = ref.read(authNotifierProvider);
                                if (!stateAfter.hasError) {
                                  context.go('/home');
                                } else {
                                  HondakuToast.showError(context, stateAfter.error.toString());
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                HondakuToast.showError(context, e.toString());
                              }
                            }
                          },
                        ),
                        const SizedBox(width: 16.0),
                        AuthSocialButton(
                          assetPath: 'assets/icons/goggle-logo.svg',
                          onTap: () async {
                            try {
                              await ref.read(authNotifierProvider.notifier).loginWithGoogle(isLoginMode: true);
                              if (context.mounted) {
                                final stateAfter = ref.read(authNotifierProvider);
                                if (!stateAfter.hasError) {
                                  context.go('/home');
                                } else {
                                  HondakuToast.showError(context, stateAfter.error.toString());
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                HondakuToast.showError(context, e.toString());
                              }
                            }
                          },
                        ),
                        const SizedBox(width: 16.0),
                        AuthIconSocialButton(
                          icon: Icons.phone_outlined,
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
}
