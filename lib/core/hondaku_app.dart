import 'package:flutter/material.dart';
import '../home/aktivitas_page.dart';
import '../home/catalog_page.dart';
import '../home/home_page.dart';
import '../home/profile.dart';


class HondakuApp extends StatefulWidget {
  const HondakuApp({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HondakuApp> createState() => _HondakuAppState();
}

class _HondakuAppState extends State<HondakuApp> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HalamanHome(
        onSeeAll: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
        onProfileClick: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
      ),
      HalamanKatalog(
        onProfileClick: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
      ),
      AktivitasPage(
        onProfileClick: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
        onStartShopping: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      ProfilePage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: HondakuBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
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
    // Jarak yang lebih seimbang untuk semua jenis perangkat
    final double bottomInset = sysBottom > 0 ? 4 : 14;

    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 6, 32, bottomInset),
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(999),
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
