import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HondakuApp extends StatelessWidget {
  const HondakuApp({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: HondakuBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class HondakuBottomNavBar extends StatelessWidget {
  const HondakuBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const Color _activeColor = Color(0xFFD50000);
  static const Color _inactiveColor = Color(0xFF8B8F98);

  @override
  Widget build(BuildContext context) {
    final double sysBottom = MediaQuery.of(context).padding.bottom;
    // Mengurangi gap agar lebih turun (standard)
    final double bottomInset = sysBottom > 0 ? 0 : 10;

    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 6, 20, bottomInset),
        child: Container(
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(24), // standard rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _HondakuBottomNavItem(
                  icon: Icons.home_filled,
                  label: 'HOME',
                  isActive: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
              ),
              Expanded(
                child: _HondakuBottomNavItem(
                  icon: Icons.motorcycle_outlined,
                  label: 'KATALOG',
                  isActive: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ),
              Expanded(
                child: _HondakuBottomNavItem(
                  icon: Icons.history,
                  label: 'AKTIVITAS',
                  isActive: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ),
              Expanded(
                child: _HondakuBottomNavItem(
                  icon: Icons.person_outline,
                  label: 'PROFIL',
                  isActive: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HondakuBottomNavItem extends StatelessWidget {
  const _HondakuBottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isActive
        ? Colors.white
        : HondakuBottomNavBar._inactiveColor;
    final Color labelColor = isActive
        ? Colors.white
        : HondakuBottomNavBar._inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 54,
          height: 54,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isActive
                ? HondakuBottomNavBar._activeColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: HondakuBottomNavBar._activeColor.withValues(
                        alpha: 0.15,
                      ),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : const [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                scale: isActive ? 1.0 : 0.95,
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                  letterSpacing: 0.2,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
