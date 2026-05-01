import 'package:flutter/material.dart';
import 'home_page.dart';
import 'catalog_page.dart';

class HondakuApp extends StatefulWidget {
  const HondakuApp({super.key});

  @override
  State<HondakuApp> createState() => _HondakuAppState();
}

class _HondakuAppState extends State<HondakuApp> {
  int _selectedIndex = 0;

  // List halaman yang dipanggil dari file terpisah
  final List<Widget> _pages = [const HalamanHome(), const HalamanKatalog()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            label: "Katalog",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Pesanan",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
