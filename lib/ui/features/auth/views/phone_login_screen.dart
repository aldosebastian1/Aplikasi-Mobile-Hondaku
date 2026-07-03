import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  final bool isLoginMode;

  const PhoneLoginScreen({super.key, required this.isLoginMode});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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
              Text(
                widget.isLoginMode ? 'Masuk dengan\nNomor HP' : 'Daftar dengan\nNomor HP',
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Kami akan mengirimkan kode OTP melalui SMS untuk verifikasi nomor Anda.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF5A4D4C),
                ),
              ),
              const SizedBox(height: 48.0),
              
              const Text(
                'NOMOR HP',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4D4C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Contoh: 08123456789',
                  prefixIcon: const Icon(Icons.phone_android),
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
                      : () {
                          String phone = _phoneController.text.trim();
                          if (phone.isEmpty) return;
                          
                          // Hapus semua karakter yang bukan angka (seperti spasi atau strip)
                          // Jika ada tanda '+', biarkan saja di awal.
                          final bool hasPlus = phone.startsWith('+');
                          phone = phone.replaceAll(RegExp(r'[^0-9]'), '');
                          
                          // Format ulang agar selalu menjadi standar internasional Firebase (+62)
                          if (phone.startsWith('0')) {
                            phone = '+62${phone.substring(1)}'; // 0812... -> +62812...
                          } else if (phone.startsWith('62')) {
                            phone = '+$phone'; // 62812... -> +62812...
                          } else if (hasPlus) {
                            phone = '+$phone'; // Jika user sudah mengetik +123...
                          } else {
                            // Default fallback (jika bukan format Indonesia)
                            phone = '+$phone';
                          }

                          ref.read(authNotifierProvider.notifier).sendOtp(
                            phoneNumber: phone,
                            isLoginMode: widget.isLoginMode,
                            onCodeSent: (verificationId) {
                              context.push('/otp', extra: {
                                'verificationId': verificationId,
                                'isLoginMode': widget.isLoginMode,
                              });
                            },
                            onError: (error) {
                              HondakuToast.showError(context, error);
                            },
                          );
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
                          'Kirim Kode OTP',
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
