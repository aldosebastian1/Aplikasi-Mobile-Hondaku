import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import to navigate to Login

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const Color _red = Color(0xFFC40000);
  static const Color _surface = Colors.white;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data konten untuk onboarding
  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title1': 'Temukan Motor',
      'title2': 'Impian.',
      'title2Color': const Color(0xFFCC0000), // Honda red
      'subtitle':
          'Jelajahi berbagai model motor Honda terbaru dengan harga OTR terbaik di wilayah Anda.',
    },
    {
      'title1': 'Simulasi Kredit',
      'title2': 'Instan',
      'title2Color': Colors.black87, // Black color for 'Instan'
      'subtitle':
          'Hitung cicilan motor impian Anda secara real-time dengan berbagai pilihan leasing terpercaya.',
    },
    {
      'title1': 'Pantau Pesanan',
      'title2': 'Anda',
      'title2Color': Colors.black87,
      'subtitle':
          'Lacak status pengiriman motor Anda dari dealer hingga sampai di depan rumah dengan fitur tracking real-time.',
    },
  ];

  // Function to navigate to Login
  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: _surface,
        border: Border(bottom: BorderSide(color: Color(0xFFE9E9E9))),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hondaku',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _red,
                  letterSpacing: -0.9,
                ),
              ),
              TextButton(
                onPressed: _navigateToLogin,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black54,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.chevron_right, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        children: [
          _buildHeader(),

            // Image Section (PageView) using local assets
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: 3, // 3 pages as per indicator
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 32.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2C2C),
                          borderRadius: BorderRadius.circular(32.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          'assets/images/onboarding${index + 1}.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF1A1A1A),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Harap tambahkan gambar:\n"assets/images/onboarding${index + 1}.png"',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Info Section
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    24.0,
                  ), // HIG: Modals & Sheets max radii 10-24
                  topRight: Radius.circular(24.0),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(
                20.0,
                24.0,
                20.0,
                48.0,
              ), // Padding changed to match standard 20 margin + 8pt grid
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Little pull indicator handle
                  Center(
                    child: Container(
                      width: 10,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),

                  // Headlines
                  Text(
                    _onboardingData[_currentPage]['title1'],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1A),
                      height: 1.1,
                      letterSpacing: -0.8,
                    ),
                  ),
                  Text(
                    _onboardingData[_currentPage]['title2'],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: _onboardingData[_currentPage]['title2Color'],
                      height: 1.1,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Subtitle
                  Text(
                    _onboardingData[_currentPage]['subtitle'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 32.0),

                  // Page Indicators
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _currentPage == index ? 24.0 : 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFFCC0000)
                                : Colors.grey[350],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 32.0),

                  // Main Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _currentPage == 2
                          ? _navigateToLogin
                          : () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFCC0000,
                        ), // Standard Red primary action
                        padding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                        ), // ~44->48 pt touch target
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            28.0,
                          ), // Keep slightly pill-shaped or fallback to pill
                        ),
                        elevation: 0, // HIG flat buttons
                      ),
                      child: Text(
                        _currentPage == 2 ? 'Mulai Sekarang' : 'Lanjutkan',
                        style: const TextStyle(
                          fontSize: 17, // HIG Body standard action
                          fontWeight: FontWeight.w600, // Medium to bold HIG CTA
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
