import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme.dart';
import '../view_models/home_view_model.dart';
import 'hero_banner_widget.dart';

class AutoSliderBanner extends ConsumerStatefulWidget {
  const AutoSliderBanner({super.key});

  @override
  ConsumerState<AutoSliderBanner> createState() => _AutoSliderBannerState();
}

class _AutoSliderBannerState extends ConsumerState<AutoSliderBanner> {
  static const _red = HondakuTheme.red;
  int _currentBanner = 0;
  final PageController _bannerController = PageController(viewportFraction: 0.88);
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
        final banners = ref.read(homeBannersProvider).value ?? const [];
        if (banners.isEmpty) return;
        if (nextPage >= banners.length) {
          nextPage = 0;
        }
        _bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 900),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(homeBannersProvider).value ?? const [];
    
    final screenWidth = MediaQuery.sizeOf(context).width;
    final sliderHeight = (screenWidth * 0.7).clamp(260.0, 360.0);
    
    if (banners.isEmpty) {
      return SizedBox(
        height: sliderHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    
    return Column(
      children: [
        SizedBox(
          height: sliderHeight,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemCount: banners.length,
            itemBuilder: (_, i) {
              final banner = banners[i];
              return AnimatedBuilder(
                animation: _bannerController,
                builder: (context, child) {
                  double page = i.toDouble();
                  if (_bannerController.position.haveDimensions) {
                    page = _bannerController.page ?? i.toDouble();
                  } else {
                    page = _currentBanner.toDouble();
                  }

                  final double value = (page - i).abs();
                  final double scale = (1 - (value * 0.12)).clamp(0.8, 1.0);
                  final double opacity = (1 - (value * 0.4)).clamp(0.4, 1.0);

                  return Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                  );
                },
                child: HeroBannerWidget(data: banner),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
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
}
