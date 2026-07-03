import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import '../../../../core/utils/error_handler.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String verificationId;
  final bool isLoginMode;

  const OtpScreen({super.key, required this.verificationId, required this.isLoginMode});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Verifikasi OTP',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Masukkan 6 digit kode OTP yang telah dikirimkan ke nomor Anda.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF5A4D4C),
                ),
              ),
              const SizedBox(height: 48.0),
              
              const Text(
                'KODE OTP',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4D4C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 8.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8).withValues(alpha: 0.5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Color(0xFFC40000), width: 2.0),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () async {
                          final String smsCode = _otpController.text.trim();
                          if (smsCode.length != 6) return;
                          
                          await ref.read(authNotifierProvider.notifier).verifyOtp(
                                verificationId: widget.verificationId,
                                smsCode: smsCode,
                                isLoginMode: widget.isLoginMode,
                              );

                          if (context.mounted) {
                            final stateAfter = ref.read(authNotifierProvider);
                            if (!stateAfter.hasError) {
                              context.go('/home');
                            } else {
                              HondakuToast.showError(context, AppErrorHandler.getMessage(stateAfter.error));
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC40000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  child: authState.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verifikasi & Masuk',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ]
    ),
      ),
    );
  }
}
