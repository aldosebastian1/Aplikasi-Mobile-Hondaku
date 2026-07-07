import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/error_state_widget.dart';
import '../../../core/widgets/motorcycle_skeleton_list.dart';

import '../../../../domain/models/motorcycle.dart';
import '../view_models/home_view_model.dart';
import '../../../core/widgets/hondaku_avatar.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/motorcycle_card_widget.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_category_selector.dart';
import 'package:hondaku/l10n/app_localizations.dart';

import '../widgets/auto_slider_banner.dart';

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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await Future.wait([
      ref.refresh(homeMotorcyclesProvider.future),
      ref.refresh(homeBannersProvider.future),
    ]);
  }

  List<Motorcycle> _getFilteredMotors(List<Motorcycle> database) {
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
    final motorcyclesAsync = ref.watch(homeMotorcyclesProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: _red,
        backgroundColor: Colors.white,
        edgeOffset: 0,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            _buildSliverHeader(),
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
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: AutoSliderBanner(),
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
                    motorcyclesAsync.when(
                      loading: () => const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        sliver: MotorcycleSkeletonList(count: 5),
                      ),
                      error: (error, stack) => SliverToBoxAdapter(
                        child: ErrorStateWidget(
                          onRetry: () => ref.refresh(homeMotorcyclesProvider.future),
                        ),
                      ),
                      data: (database) {
                        final filteredMotors = _getFilteredMotors(database);
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: filteredMotors.isEmpty
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
                                      motor: filteredMotors[i],
                                      isCompact: true,
                                      parentIndex: 0,
                                    ),
                                    childCount: filteredMotors.length,
                                  ),
                                ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
        ),
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: _surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color(0xFFE9E9E9),
          height: 1.0,
        ),
      ),
      title: Row(
        children: [
          Image.asset(
            'assets/images/logos/logo.png',
            height: 32,
            fit: BoxFit.contain,
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
