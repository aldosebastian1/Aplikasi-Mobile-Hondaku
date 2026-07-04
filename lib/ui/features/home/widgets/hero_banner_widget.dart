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
        final title1Size = (constraints.maxWidth * 0.08).clamp(22.0, 28.0);
        final title2Size = (constraints.maxWidth * 0.06).clamp(16.0, 22.0);
        final subtitleSize = (constraints.maxWidth * 0.04).clamp(13.0, 15.0); // Diperbesar dari 11-13 ke 13-15 sesuai standar keterbacaan mobile
        final gapTagToTitle = (constraints.maxWidth * 0.045).clamp(6.0, 12.0); // Diperkecil agar tidak overflow vertikal
        final gapTitleToDivider = (constraints.maxWidth * 0.05).clamp(10.0, 16.0); // Diperkecil
        final gapDividerToSubtitle = (constraints.maxWidth * 0.035).clamp(6.0, 10.0); // Diperkecil
        final badgePaddingV = (constraints.maxWidth * 0.018).clamp(4.0, 6.0);
        final badgePaddingH = (constraints.maxWidth * 0.04).clamp(10.0, 14.0);


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
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: verticalPadding,
              bottom: verticalPadding, // Kembali ke simetris agar ruang berimbang
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 11.5, // Diperbesar dari 10.5 agar lebih standar
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: gapTagToTitle),
                // Title 1
                Text(
                  data.title1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: title1Size,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    height: 1.1,
                    letterSpacing: -0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Title 2
                Text(
                  data.title2,
                  style: TextStyle(
                    color: themeRed,
                    fontSize: title2Size,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: gapTitleToDivider),
                // Divider Line
                Container(
                  width: 32, 
                  height: 3, 
                  decoration: BoxDecoration(
                    color: themeRed,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: gapDividerToSubtitle),
                // Subtitle / Description
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  height: subtitleSize * 1.4 * 3, // Mengunci tinggi ke 3 baris
                  child: Text(
                    data.subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: subtitleSize,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
