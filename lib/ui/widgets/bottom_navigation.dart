import 'package:animebrowser/ui/pages/overview_page.dart';
import 'package:animebrowser/ui/pages/settings_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _MainMenuState();
}

class _MainMenuState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const _pages = [
    OverviewPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          OverviewPage.navItem,
          SettingsPage.navItem,
        ],
        onTap: (index) => setState(() {_selectedIndex = index;}),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
