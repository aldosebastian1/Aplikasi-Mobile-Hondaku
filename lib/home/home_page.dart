import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/motorcycle_data.dart';
import '../domain/models/motorcycle.dart';
import '../domain/models/hero_banner.dart';
import '../ui/features/home/view_models/home_view_model.dart';
import 'product_detail_screen.dart';
import '../booking/checkout_payment_method_page.dart';
import '../data/hero_banner_data.dart';
import 'catalog_page.dart';
import 'user_store.dart';

class HalamanHome extends ConsumerStatefulWidget {
  final VoidCallback? onSeeAll;
  const HalamanHome({super.key, this.onSeeAll});

  @override
  ConsumerState<HalamanHome> createState() => _HalamanHomeState();
}

class _HalamanHomeState extends ConsumerState<HalamanHome> {
  static const _red = Color(0xFFC40000);
  static const _surface = Colors.white;
  int _currentBanner = 0;
  final PageController _bannerController = PageController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = '';
  Timer? _bannerTimer;

  final List<Map<String, dynamic>> _kategori = [
    {'icon': Icons.motorcycle, 'label': 'MATIC'},
    {'icon': Icons.sports_motorsports, 'label': 'SPORT'},
    {'icon': Icons.electric_moped, 'label': 'CUB'},
    {'icon': Icons.electric_bolt, 'label': 'ELECTRIC'},
  ];

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        int nextPage = _currentBanner + 1;
        final banners =
            ref.read(homeBannersProvider).value ?? heroBannersDatabase;
        if (nextPage >= banners.length) {
          nextPage = 0;
        }
        _bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Motorcycle> get _filteredMotors {
    final database =
        ref.watch(homeMotorcyclesProvider).value ?? motorcycleDatabase;
    List<Motorcycle> motors = database;

    // Filter by category (if selected)
    if (_selectedCategory.isNotEmpty) {
      motors = motors
          .where((m) => m.categoryBadge.toUpperCase() == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isEmpty) return motors;
    return motors.where((m) {
      return m.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          m.categoryBadge.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          m.subtitle.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: _buildSearchBar(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: _buildBanner(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: _buildKategori(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: _buildRekomendasiHeader(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: _filteredMotors.isEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 64,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Motor "$_searchQuery" tidak ditemukan',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) => _buildMotorCard(_filteredMotors[i]),
                              childCount: _filteredMotors.length,
                            ),
                          ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ],
        ),
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
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: 12, color: Color(0xFFC40000)),
                    const SizedBox(width: 4),
                    Text(
                      'OTR MEDAN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              UserStore.buildReactiveAvatar(radius: 20, fontSize: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48, // Standard height for search bars
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val;
          });
        },
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Cari motor idaman...',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey.shade500),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final banners = ref.watch(homeBannersProvider).value ?? heroBannersDatabase;
    return Column(
      children: [
        SizedBox(
          height:
              320, // Reverted to original height while maintaining new style
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemCount: banners.length,
            itemBuilder: (_, i) => _buildBannerItem(banners[i]),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (i) {
            final isActive = i == _currentBanner;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? _red : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBannerItem(HeroBanner data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = (constraints.maxWidth * 0.08).clamp(16.0, 28.0);
        final verticalPadding = (constraints.maxWidth * 0.08).clamp(16.0, 28.0);
        final title1Size = (constraints.maxWidth * 0.12).clamp(28.0, 44.0);
        final title2Size = (constraints.maxWidth * 0.08).clamp(20.0, 28.0);
        final subtitleSize = (constraints.maxWidth * 0.042).clamp(11.5, 14.0);
        final gap1 = (constraints.maxWidth * 0.045).clamp(8.0, 16.0);
        final gap2 = (constraints.maxWidth * 0.035).clamp(6.0, 12.0);
        final badgePaddingV = (constraints.maxWidth * 0.018).clamp(4.0, 6.0);
        final badgePaddingH = (constraints.maxWidth * 0.04).clamp(10.0, 14.0);
        final buttonPaddingV = (constraints.maxWidth * 0.035).clamp(8.0, 12.0);
        final buttonPaddingH = (constraints.maxWidth * 0.065).clamp(16.0, 22.0);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: DecorationImage(
              image: AssetImage(data.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.85),
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.45, 0.9],
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag / Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: badgePaddingH,
                    vertical: badgePaddingV,
                  ),
                  decoration: BoxDecoration(
                    color: _red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: gap1),
                // Title 1
                Text(
                  data.title1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: title1Size,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    height: 0.9,
                    letterSpacing: -1.5,
                  ),
                ),
                // Title 2
                Text(
                  data.title2,
                  style: TextStyle(
                    color: _red,
                    fontSize: title2Size,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    letterSpacing: -0.8,
                  ),
                ),
                SizedBox(height: gap2),
                // Divider Line
                Container(width: 28, height: 2.5, color: _red),
                SizedBox(height: gap2),
                // Subtitle / Description
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  child: Text(
                    data.subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: subtitleSize,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                // Explore Button
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPaddingH,
                    vertical: buttonPaddingV,
                  ),
                  decoration: BoxDecoration(
                    color: _red,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Explore Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 11,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildKategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _kategori.map((k) {
            final isSelected = _selectedCategory == k['label'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle category: if already selected, reset to all ('')
                  _selectedCategory = isSelected ? '' : k['label'] as String;
                });
              },
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _red.withValues(alpha: 0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? _red : Colors.grey.shade200,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Icon(k['icon'] as IconData, color: _red, size: 28),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    k['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      color: isSelected ? _red : Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRekomendasiHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PILIHAN TERBAIK',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _red,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Rekomendasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSeeAll != null) {
                  widget.onSeeAll!();
                } else {
                  // Fallback if not inside HondakuApp
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamanKatalog(),
                    ),
                  );
                }
              },
              child: const Text(
                'LIHAT SEMUA',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMotorCard(Motorcycle motor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar motor
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              width: double.infinity,
              height: 180,
              color: Colors.white,
              child: Image.asset(
                motor.imageAsset,
                fit: BoxFit.contain,
                height: 180,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          motor.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          motor.subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'STARTING FROM',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            letterSpacing: 0.3,
                          ),
                        ),
                        Text(
                          motor.price,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                parentIndex: 0,
                                motor: motor,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Detail',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutPaymentMethodPage(motor: motor),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Beli',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
