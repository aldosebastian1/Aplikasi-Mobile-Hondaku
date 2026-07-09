import 'package:flutter/material.dart';
import 'package:hondaku/l10n/app_localizations.dart';
import 'package:hondaku/ui/core/theme.dart';

class HomeCategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<Map<String, dynamic>> _categories = [
    {'icon': Icons.motorcycle, 'label': 'MATIC'},
    {'icon': Icons.sports_motorsports, 'label': 'SPORT'},
    {'icon': Icons.electric_moped, 'label': 'CUB'},
    {'icon': Icons.electric_bolt, 'label': 'EV'},
  ];

  const HomeCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    const red = HondakuTheme.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.categories,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _categories.map((k) {
            final label = k['label'] as String;
            final isSelected = selectedCategory == label;
            return GestureDetector(
              onTap: () {
                onCategorySelected(isSelected ? '' : label);
              },
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? red.withValues(alpha: 0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? red : Colors.grey.shade200,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Icon(k['icon'] as IconData, color: red, size: 28),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      color: isSelected ? red : Colors.black87,
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
}
