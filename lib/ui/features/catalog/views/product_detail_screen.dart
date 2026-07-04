import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/motorcycle_data.dart';
import '../../../core/hondaku_app.dart';
import '../../../core/widgets/hondaku_toast.dart';
import '../widgets/specs_section_widget.dart';
import '../../favorites/providers/favorite_provider.dart';
import 'package:hondaku/l10n/app_localizations.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int parentIndex;
  final Motorcycle motor;
  const ProductDetailScreen({
    super.key,
    this.parentIndex = 1,
    required this.motor,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  late int _selectedBottomIndex;

  @override
  void initState() {
    super.initState();
    _selectedBottomIndex = widget.parentIndex;
  }

  static const _surface = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 16),
                  _buildTitlePriceSection(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SpecsSectionWidget(motor: widget.motor, isDetailed: false),
                  ),
                  const SizedBox(height: 20),
                  _buildFeaturesSection(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SpecsSectionWidget(motor: widget.motor, isDetailed: true),
                  ),
                  const SizedBox(height: 40),
                  _buildBottomButtonsSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Watch the favorite provider
    final favoritesList = ref.watch(favoriteProvider);
    final isFav = favoritesList.contains(widget.motor.id);

    return Container(
      decoration: const BoxDecoration(
        color: _surface,
        border: Border(bottom: BorderSide(color: Color(0xFFE9E9E9))),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          child: Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.black87,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Color(0xFFC40000)),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.otrMedan,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? const Color(0xFFC40000) : Colors.grey[600],
                  size: 26,
                ),
                onPressed: () {
                  ref.read(favoriteProvider.notifier).toggleFavorite(widget.motor);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeroSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD50000),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD50000).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                AppLocalizations.of(context)!.specialPromo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F9),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.24),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: Image.asset(
                    widget.motor.imageAsset,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    cacheWidth: 800,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          // TODO: Fitur Pilihan Warna dinonaktifkan sementara karena membutuhkan implementasi yang kompleks
          // _buildColorSelectors(),
          // const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildColorSelectors() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _colorCircle(const Color(0xFF6A625C), true),
            const SizedBox(width: 10),
            _colorCircle(Colors.black, false),
            const SizedBox(width: 10),
            _colorCircle(const Color(0xFFD7DCE3), false, border: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _colorCircle(Color color, bool selected, {Color? border}) {
    if (selected) {
      return Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFCCCCCC), width: 1.2),
          ),
        ),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border != null ? Border.all(color: border, width: 1) : null,
      ),
    );
  }

  Widget _buildTitlePriceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.motor.subtitle,
            style: const TextStyle(color: Color(0xFF2F2F2F), fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            widget.motor.name.toUpperCase(),
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF7F8), Color(0xFFFBF4F5)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.otrJakarta,
                  style: const TextStyle(
                    color: Color(0xFF7D5D5D),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.startingFrom,
                        style: const TextStyle(color: Color(0xFFE11D48)),
                      ),
                      TextSpan(
                        text: widget.motor.price,
                        style: const TextStyle(color: Color(0xFF1A1A1A)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(AppLocalizations.of(context)!.techFeatures),
          const SizedBox(height: 16),
          ...widget.motor.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _featureItem(
                feature.icon ?? Icons.star_border,
                feature.title,
                feature.description,
              ),

            ),
          ),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFFC01F2D)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildBottomButtonsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // TANYA SALES Button (Grey)
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement contact sales functionality
                HondakuToast.showInfo(context, 'Hubungi sales untuk informasi lebih lanjut');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1C1C1E),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                side: const BorderSide(color: Color(0xFFF0C7C7)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.askSales,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // BELI SEKARANG Button (Red)
          Expanded(
            flex: 6,
            child: ElevatedButton(
              onPressed: () => context.push('/checkout-payment', extra: widget.motor),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD50000),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 6,
                shadowColor: const Color(0xFFD50000).withValues(alpha: 0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.buyNow,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return HondakuBottomNavBar(
      currentIndex: _selectedBottomIndex,
      onTap: (index) => _handleBottomNavTap(context, index),
    );
  }

  Future<void> _handleBottomNavTap(BuildContext context, int index) async {
    if (_selectedBottomIndex == index) {
      return;
    }

    setState(() {
      _selectedBottomIndex = index;
    });

    await Future<void>.delayed(const Duration(milliseconds: 140));

    if (!context.mounted) {
      return;
    }

    final paths = ['/home', '/catalog', '/aktivitas', '/profile'];
    context.go(paths[index]);
  }
}
