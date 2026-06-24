import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      'title2Color': const Color(0xFFC40000), // Honda red
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

  void _navigateToLogin() {
    context.go('/login');
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
              const Text(
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final bool isSmallScreen = screenHeight < 680;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool useWideLayout = constraints.maxWidth >= 600 ||
              (constraints.maxWidth > constraints.maxHeight && constraints.maxHeight < 500);

          if (useWideLayout) {
            return _buildWideLayout(context, constraints, isSmallScreen);
          } else {
            return _buildPortraitLayout(context, constraints, isSmallScreen);
          }
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, BoxConstraints constraints, bool isSmallScreen) {
    const double buttonHeight = 56.0;

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Side: Image PageView
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C2C2C),
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 24,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(
                              'assets/images/onboarding${index + 1}.jpg',
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
                                        'Harap tambahkan gambar:\n"assets/images/onboarding${index + 1}.jpg"',
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
                      ),
                    );
                  },
                ),
              ),
              // Vertical Divider
              Container(
                width: 1,
                color: const Color(0xFFE9E9E9),
              ),
              // Right Side: Info Section (Scrollable to prevent overflow)
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    left: false,
                    top: false,
                    bottom: true,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                          child: _buildBottomContent(
                            titleFontSize: 28.0,
                            subtitleFontSize: 15.0,
                            spaceBeforeIndicator: 24.0,
                            spaceBeforeButton: 24.0,
                            buttonHeight: buttonHeight,
                            showPullIndicator: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context, BoxConstraints constraints, bool isSmallScreen) {
    final bool hideImage = constraints.maxHeight < 520;

    // Responsive spacings and padding
    final double imagePaddingTop = isSmallScreen ? 10.0 : 20.0;
    final double imagePaddingBottom = isSmallScreen ? 12.0 : 32.0;
    final double bottomSheetPaddingBottom = isSmallScreen ? 20.0 : 48.0;
    final double bottomSheetPaddingTop = isSmallScreen ? 16.0 : 24.0;
    final double spaceBeforeIndicator = isSmallScreen ? 16.0 : 32.0;
    final double spaceBeforeButton = isSmallScreen ? 16.0 : 32.0;
    final double buttonHeight = isSmallScreen ? 48.0 : 56.0;

    // Responsive text sizes
    final double titleFontSize = isSmallScreen ? 24.0 : 30.0;
    final double subtitleFontSize = isSmallScreen ? 14.0 : 16.0;

    return Column(
      children: [
        _buildHeader(),

        // Image Section (PageView) using local assets
        if (!hideImage)
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(24.0, imagePaddingTop, 24.0, imagePaddingBottom),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/images/onboarding${index + 1}.jpg',
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
                                  'Harap tambahkan gambar:\n"assets/images/onboarding${index + 1}.jpg"',
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
        Flexible(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                20.0,
                bottomSheetPaddingTop,
                20.0,
                bottomSheetPaddingBottom,
              ),
              child: _buildBottomContent(
                titleFontSize: titleFontSize,
                subtitleFontSize: subtitleFontSize,
                spaceBeforeIndicator: spaceBeforeIndicator,
                spaceBeforeButton: spaceBeforeButton,
                buttonHeight: buttonHeight,
                showPullIndicator: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContent({
    required double titleFontSize,
    required double subtitleFontSize,
    required double spaceBeforeIndicator,
    required double spaceBeforeButton,
    required double buttonHeight,
    required bool showPullIndicator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPullIndicator)
          // Little pull indicator handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),

        // Headlines
        Text(
          _onboardingData[_currentPage]['title1'],
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1A1A1A),
            height: 1.1,
            letterSpacing: -0.8,
          ),
        ),
        Text(
          _onboardingData[_currentPage]['title2'],
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w900,
            color: _onboardingData[_currentPage]['title2Color'],
            height: 1.1,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 12.0),

        // Subtitle
        Text(
          _onboardingData[_currentPage]['subtitle'],
          style: TextStyle(
            fontSize: subtitleFontSize,
            color: Colors.grey[700],
            height: 1.4,
            letterSpacing: 0.1,
          ),
        ),
        SizedBox(height: spaceBeforeIndicator),

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
                  color: _currentPage == index ? const Color(0xFFC40000) : Colors.grey[350],
                  borderRadius: BorderRadius.circular(4.0),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: spaceBeforeButton),

        // Main Button
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: _currentPage == 2
                ? _navigateToLogin
                : () {
                    if (_pageController.hasClients) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      setState(() {
                        _currentPage = (_currentPage + 1) % 3;
                      });
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC40000),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonHeight / 2),
              ),
            ),
            child: Text(
              _currentPage == 2 ? 'Mulai Sekarang' : 'Lanjutkan',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
