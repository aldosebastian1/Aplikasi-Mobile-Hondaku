import 'dart:async';
import 'package:flutter/material.dart';
import 'data/motorcycle_data.dart'; // <-- Database terpanggil
import 'data/hero_banner_data.dart'; // <-- Database Hero Banner terpanggil

class HalamanHome extends StatelessWidget {
  const HalamanHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Apple HIG: Safe and generous margins
    const double horizontalPadding = 20.0;

    return Scaffold(
      backgroundColor: Colors.white, // HIG: Pure white background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Area
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo Text
                    const Text(
                      "Hondaku",
                      style: TextStyle(
                        color: Color(0xFFD50000), // Honda Red
                        fontSize: 24,
                        fontWeight: FontWeight.w900, // Black/Heavy weight
                        letterSpacing: -0.5,
                      ),
                    ),
                    // Location Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F7), // HIG SystemGray6
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFFD50000),
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "OTR MEDAN",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C1C1E),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Profile Picture
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://i.pravatar.cc/150?u=honda",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 8.0,
                ),
                child: Container(
                  height: 44, // HIG Standard touch target
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Smooth squircle approximation
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFF1C1C1E), size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Cari motor idaman...",
                        style: TextStyle(
                          color: Color(0xFF8E8E93), // HIG SystemGray
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Hero Banner Widget (Auto Slide Carousel)
              const HeroCarousel(horizontalPadding: horizontalPadding),

              const SizedBox(height: 32),

              // Categories Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Kategori",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800, // Heavy weight
                    color: Color(0xFF1C1C1E),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Categories Icons
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem(Icons.moped, "MATIC"),
                    _buildCategoryItem(Icons.sports_motorsports, "SPORT"),
                    _buildCategoryItem(Icons.two_wheeler, "CUB"),
                    _buildCategoryItem(Icons.electric_bolt, "ELECTRIC"),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Rekomendasi Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PILIHAN TERBAIK",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD50000),
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rekomendasi",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1C1C1E),
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          "LIHAT SEMUA",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD50000),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Recommendations List (Dipanggil dari Database Mock)
              ...motorcycleDatabase.where((m) => m.isRecommended).take(1).map((
                motor,
              ) {
                return _buildRecommendationCard(
                  name: motor.name,
                  subtitle: motor.subtitle,
                  price: motor.price,
                  imageAsset: motor.imageAsset,
                  isNew: motor.isNew,
                );
              }),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 64, // Apple touch target larger than 44
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7), // HIG SystemGray6
            borderRadius: BorderRadius.circular(20), // Soft squircle
          ),
          child: Icon(icon, color: const Color(0xFFD50000), size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard({
    required String name,
    required String subtitle,
    required String price,
    required String imageAsset,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1,
        ), // Light hairline border Apple style
        boxShadow: [
          // Extremely subtle drop shadow for depth parity with image
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image layer
                Image.asset(imageAsset, height: 180, fit: BoxFit.contain),

                const SizedBox(height: 16),

                // Detailed Title and Price Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Naming Area
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800, // Black text weight
                            color: Color(0xFF1C1C1E),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                    // Pricing Area
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "STARTING FROM",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8E8E93),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFD50000), // Honda Red bold
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Action Buttons Row
                Row(
                  children: [
                    // Detail Button (Grey)
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFE5E5EA,
                          ), // Apple SystemGray5
                          foregroundColor: const Color(
                            0xFF1C1C1E,
                          ), // Near black
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0, // Flat Apple default
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Detail",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12), // Strict baseline margin
                    // Beli Button (Red)
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD50000),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Beli",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (isNew)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E5EA)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  "New !",
                  style: TextStyle(
                    color: Color(0xFFD50000),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ==== STATEFUL WIDGET UNTUK AUTO SLIDER HERO BANNER ====
class HeroCarousel extends StatefulWidget {
  final double horizontalPadding;
  const HeroCarousel({super.key, required this.horizontalPadding});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    // Timer auto slide tiap 4 detik
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % heroBannersDatabase.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          height: 340, // Disesuaikan agar proporsional dan tidak terlalu besar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28), // Sudut lebih membulat
            color: const Color(0xFF1C1C1E),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: heroBannersDatabase.length,
            itemBuilder: (context, index) {
              final banner = heroBannersDatabase[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      banner.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  // Gradient Overlay iOS Style (Hitam ke transparant agar text terbaca)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.9),
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Content Overlaid Text
                  Padding(
                    padding: const EdgeInsets.all(
                      24.0,
                    ), // Diperkecil dari 28 agar spasi lebih lega
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Konten sejajar bawah
                      children: [
                        // Tag Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD50000), // Merah Honda
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            banner.tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Title 1
                        Text(
                          banner.title1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28, // Diperkecil proporsional
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            letterSpacing: -0.5,
                          ),
                        ),
                        // Title 2
                        Text(
                          banner.title2,
                          style: const TextStyle(
                            color: Color(
                              0xFFF28B82,
                            ), // Merah salmon sesuai gambar
                            fontSize: 28, // Diperkecil proporsional
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Subtitle
                        Text(
                          banner.subtitle,
                          style: const TextStyle(
                            color: Color(0xFFE5E5EA), // SystemGray5
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ), // Pengganti Spacer agar proporsional di bawah
                        // Action Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD50000),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Learn More",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Dots Indicator Animasi
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(heroBannersDatabase.length, (index) {
            bool isActive = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 24 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFD50000)
                    : const Color(0xFFE5E5EA),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}
