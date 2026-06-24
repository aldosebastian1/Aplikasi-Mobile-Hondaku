import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/ui/core/theme.dart';
import 'package:hondaku/l10n/app_localizations.dart';

class MotorcycleCardWidget extends StatelessWidget {
  final Motorcycle motor;
  final bool isCompact;
  final int parentIndex;

  const MotorcycleCardWidget({
    super.key,
    required this.motor,
    this.isCompact = false,
    this.parentIndex = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const themeRed = HondakuTheme.red;

    return Container(
      margin: EdgeInsets.only(bottom: isCompact ? 14 : 16),
      decoration: HondakuTheme.premiumCardDecoration(isDark: isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar motor
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              width: double.infinity,
              height: isCompact ? 180 : 220,
              color: isDark ? HondakuTheme.darkBg : Colors.white,
              child: Image.asset(
                motor.imageAsset,
                fit: BoxFit.contain,
                height: isCompact ? 180 : 220,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, isCompact ? 12 : 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isCompact) ...[
                  // Badge kategori (hanya di mode non-compact / catalog)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? HondakuTheme.darkBorder : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      motor.categoryBadge,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isDark ? HondakuTheme.darkTextSecondary : Colors.grey.shade600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            motor.name,
                            style: HondakuTheme.headlineStyle(isDark: isDark, fontSize: isCompact ? 18 : 22),
                          ),
                          if (isCompact) ...[
                            Text(
                              motor.subtitle,
                              style: HondakuTheme.bodyStyle(isDark: isDark, fontSize: 12),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isCompact) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.startingFrom.trim().toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? HondakuTheme.darkTextSecondary : Colors.grey,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            motor.price,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: themeRed,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                if (!isCompact) ...[
                  const SizedBox(height: 4),
                  Text(
                    motor.description,
                    style: HondakuTheme.bodyStyle(isDark: isDark, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    AppLocalizations.of(context)!.startingFrom.trim().toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isDark ? HondakuTheme.darkTextSecondary : Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    motor.price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeRed,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.push(
                            '/product-detail',
                            extra: isCompact ? {'motor': motor, 'parentIndex': parentIndex} : motor,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark ? HondakuTheme.darkBorder : Colors.grey.shade300,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.detail,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? HondakuTheme.darkTextPrimary : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/checkout-payment', extra: motor);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeRed,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.buy,
                          style: const TextStyle(
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
