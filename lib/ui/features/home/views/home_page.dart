import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/motorcycle_data.dart';
import '../view_models/home_view_model.dart';
import '../../../../data/hero_banner_data.dart';
import '../../profile/stores/user_store.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/motorcycle_card_widget.dart';
import '../widgets/hero_banner_widget.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_category_selector.dart';
import 'package:hondaku/l10n/app_localizations.dart';

class HalamanHome extends ConsumerStatefulWidget {
  final VoidCallback? onSeeAll;
  final VoidCallback? onProfileClick;
  const HalamanHome({super.key, this.onSeeAll, this.onProfileClick});

  @override
  ConsumerState<HalamanHome> createState() => _HalamanHomeState();
}

class _HalamanHomeState extends ConsumerState<HalamanHome> {
  static const _red = HondakuTheme.red;
  static const _surface = Colors.white;
  int _currentBanner = 0;
  final PageController _bannerController = PageController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = '';
  Timer? _bannerTimer;

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

  Future<void> _handleRefresh() async {
    await Future.wait([
      ref.refresh(homeMotorcyclesProvider.future),
      ref.refresh(homeBannersProvider.future),
    ]);
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
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: _red,
                backgroundColor: Colors.white,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: HomeSearchBar(
                          controller: _searchController,
                          searchQuery: _searchQuery,
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                          onClear: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        ),
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
                        child: HomeCategorySelector(
                          selectedCategory: _selectedCategory,
                          onCategorySelected: (val) {
                            setState(() {
                              _selectedCategory = val;
                            });
                          },
                        ),
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
                                        AppLocalizations.of(context)!.motorNotFound(_searchQuery),
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
                                (_, i) => MotorcycleCardWidget(
                                  motor: _filteredMotors[i],
                                  isCompact: true,
                                  parentIndex: 0,
                                ),
                                childCount: _filteredMotors.length,
                              ),
                            ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
                ),
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
              const Text(
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
              GestureDetector(
                onTap: widget.onProfileClick,
                child: const HondakuAvatar(radius: 20, fontSize: 12),
              ),
            ],
          ),
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
            itemBuilder: (_, i) => HeroBannerWidget(data: banners[i]),
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


  Widget _buildRekomendasiHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.bestChoice,
          style: const TextStyle(
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
            Text(
              AppLocalizations.of(context)!.recommendations,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSeeAll != null) {
                  widget.onSeeAll!();
                } else {
                  context.go('/catalog');
                }
              },
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: const TextStyle(
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
}
