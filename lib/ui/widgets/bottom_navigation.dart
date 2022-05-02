import 'package:anilist_browser/ui/pages/overview_page.dart';
import 'package:anilist_browser/ui/pages/settings_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _MainMenuState();
}

class _MainMenuState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const _pages = [
    Overview(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const <BottomNavigationBarItem>[
          Overview.navItem,
          Settings.navItem,
        ],
      ),
    );
  }
}
