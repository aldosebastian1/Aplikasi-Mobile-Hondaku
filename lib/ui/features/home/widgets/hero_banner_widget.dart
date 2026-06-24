import 'package:flutter/material.dart';
import 'package:hondaku/domain/models/hero_banner.dart';
import 'package:hondaku/ui/core/theme.dart';

class HeroBannerWidget extends StatelessWidget {
  final HeroBanner data;

  const HeroBannerWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    const themeRed = HondakuTheme.red;

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
                    color: themeRed,
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
                    color: themeRed,
                    fontSize: title2Size,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    letterSpacing: -0.8,
                  ),
                ),
                SizedBox(height: gap2),
                // Divider Line
                Container(width: 28, height: 2.5, color: themeRed),
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
                    color: themeRed,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Explore Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
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
}
