import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import to navigate to Login

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F8F8,
      ), // Light gray background for top section
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar Area
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'HONDAKU',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFCC0000), // Honda Red
                      letterSpacing: -0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToLogin,
                    child: const Text(
                      'Skip >',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                    padding: const EdgeInsets.all(32.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF333333,
                        ), // Dark placeholder background
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        // Menggunakan gambar lokal: assets/images/onboarding1.png, dst.
                        'assets/images/onboarding${index + 1}.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        // Menanangi error jika gambar belum Anda masukkan ke folder
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Harap tambahkan gambar:\n"assets/images/onboardin${index + 1}.png"',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          );
                        },
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
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Little pull indicator handle
                  Center(
                    child: Container(
                      width: 40,
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
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      height: 1.1,
                      letterSpacing: -1.0,
                    ),
                  ),
                  Text(
                    _onboardingData[_currentPage]['title2'],
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: _onboardingData[_currentPage]['title2Color'],
                      height: 1.1,
                      letterSpacing: -1.0,
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
                        backgroundColor: const Color(0xFFCC0000), // Red button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == 2 ? 'Mulai Sekarang' : 'Mulai Sekarang',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
