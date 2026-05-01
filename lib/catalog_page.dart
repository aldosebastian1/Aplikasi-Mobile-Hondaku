import 'package:flutter/material.dart';
import 'data/motorcycle_data.dart'; // Terintegrasi dengan Mock Database

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    // Apple HIG: Safe and generous margins
    const double horizontalPadding = 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // HIG System group background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Area (Sama dengan Home Page)
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
                        color: const Color(
                          0xFFE5E5EA,
                        ), // HIG SystemGray5 for slight contrast
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

              const SizedBox(height: 16),

              // Title & Description Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ENGINEERED FOR PERFORMANCE",
                      style: TextStyle(
                        color: Color(0xFFD50000),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Precision\nMachine.",
                      style: TextStyle(
                        fontSize: 42, // Extra large title typical of iOS
                        fontWeight: FontWeight.w900, // Very heavy typography
                        color: Color(0xFF1C1C1E),
                        height: 0.95, // Tight line height Apple config
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          // Red vertical line accent
                          Container(width: 3, color: const Color(0xFFD50000)),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              "Explore the complete range of Honda\nmotorcycles, from aggressive super sports to\nversatile urban commuters.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(
                                  0xFF5A5A5E,
                                ), // Slightly darker grey for readability
                                height: 1.4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Filter Chips
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Row(
                  children: [
                    _buildFilterChip("All Models", true),
                    const SizedBox(width: 10),
                    _buildFilterChip("Price", false),
                    const SizedBox(width: 10),
                    _buildFilterChip("Popularity", false),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // RECOMMENDATIONS HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "RECOMMENDATIONS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800, // Heavy weight
                        color: Color(0xFF1C1C1E),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.tune, size: 14, color: Color(0xFFD50000)),
                        SizedBox(width: 4),
                        Text(
                          "FILTER",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD50000),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Product Cards List (Semua katalog ditampilkan)
              ...motorcycleDatabase.map((motor) {
                return _buildCatalogCard(
                  categoryBadge: motor.categoryBadge,
                  name: motor.name,
                  description: motor.description,
                  price: motor.price,
                  imageAsset: motor.imageAsset,
                );
              }),

              const SizedBox(height: 32), // Safe bottom margin
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFD50000)
            : const Color(0xFFE5E5EA), // Red vs SystemGray5
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive) ...[
            const Icon(Icons.sort, color: Colors.white, size: 14),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF1C1C1E),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogCard({
    required String categoryBadge,
    required String name,
    required String description,
    required String price,
    required String imageAsset,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1,
        ), // Hairline border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ), // Ultra soft HIG shadow
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image (Using Beat 1.png as requested)
            Center(
              child: Image.asset(imageAsset, height: 180, fit: BoxFit.contain),
            ),

            const SizedBox(height: 24),

            // Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5EA), // SystemGray5
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                categoryBadge,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1C1C1E),
                  letterSpacing: 1.0,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Product Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 6),

            // Product Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5A5A5E),
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 20),

            // Pricing Info
            const Text(
              "STARTING FROM",
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E8E93),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFFD50000), // Honda Red
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                // Detail Button
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5E5EA),
                      foregroundColor: const Color(0xFF1C1C1E),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ), // Tall touch target iOS
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Pill shape
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
                const SizedBox(width: 12),
                // Book Now Button
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD50000), // Action Red
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
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
    );
  }
}
