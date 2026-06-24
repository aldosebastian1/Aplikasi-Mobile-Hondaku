import 'package:flutter/material.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/ui/core/theme.dart';

class SpecsSectionWidget extends StatelessWidget {
  final Motorcycle motor;
  final bool isDetailed;

  const SpecsSectionWidget({
    super.key,
    required this.motor,
    this.isDetailed = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const themeRed = HondakuTheme.red;

    if (isDetailed) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('SPESIFIKASI DETAIL', isDark),
          const SizedBox(height: 16),
          _detailedSpecCategory('Mesin', Icons.settings_suggest_outlined, themeRed),
          const SizedBox(height: 16),
          _specTable(
            motor.specsMesin.entries
                .map((e) => _specTableRow(e.key, e.value, isDark))
                .toList(),
            isDark,
          ),
          const SizedBox(height: 20),
          _detailedSpecCategory(
            'Rangka & Kaki-Kaki',
            Icons.motorcycle_outlined,
            themeRed,
          ),
          const SizedBox(height: 16),
          _specTable(
            motor.specsRangka.entries
                .map((e) => _specTableRow(e.key, e.value, isDark))
                .toList(),
            isDark,
          ),
          const SizedBox(height: 20),
          _detailedSpecCategory(
            'Dimensi & Kapasitas',
            Icons.linear_scale_outlined,
            themeRed,
          ),
          const SizedBox(height: 16),
          _specTable(
            motor.specsDimensi.entries
                .map((e) => _specTableRow(e.key, e.value, isDark))
                .toList(),
            isDark,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('SPESIFIKASI UTAMA', isDark),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _specItem(
              Icons.settings_suggest_outlined,
              motor.engine,
              'ENGINE',
              themeRed,
              isDark,
            ),
            _specItem(
              Icons.speed_outlined,
              motor.maxPower,
              'POWER',
              themeRed,
              isDark,
            ),
            _specItem(
              Icons.local_gas_station_outlined,
              motor.fuelCapacity,
              'FUEL',
              themeRed,
              isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: isDark ? HondakuTheme.darkTextPrimary : HondakuTheme.lightTextPrimary,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _specItem(
    IconData icon,
    String value,
    String label,
    Color themeRed,
    bool isDark,
  ) {
    return Container(
      width: 94,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? HondakuTheme.darkSurface : const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? HondakuTheme.darkBorder : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isDark ? HondakuTheme.darkBg : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: themeRed),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: isDark ? HondakuTheme.darkTextPrimary : HondakuTheme.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isDark ? HondakuTheme.darkTextSecondary : Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailedSpecCategory(String title, IconData icon, Color themeRed) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
          ),
          child: Icon(icon, size: 20, color: themeRed),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _specTable(List<Widget> rows, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? HondakuTheme.darkSurface : const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? HondakuTheme.darkBorder : const Color(0xFFECEFF1),
          width: 0.5,
        ),
      ),
      child: Column(
        children: List.generate(
          rows.length,
          (index) => Column(
            children: [
              rows[index],
              if (index < rows.length - 1)
                Divider(
                  height: 1,
                  color: isDark ? HondakuTheme.darkBorder : const Color(0xFFECEFF1),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specTableRow(String label, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? HondakuTheme.darkTextSecondary : Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: isDark ? HondakuTheme.darkTextPrimary : HondakuTheme.lightTextPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
