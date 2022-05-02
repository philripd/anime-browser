import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anilist_browser/page/overview_page.dart';
import 'package:anilist_browser/page/settings_page.dart';
import 'package:anilist_browser/provider/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
            title: 'AniList Browser',
            themeMode: provider.themeMode,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            home: const MainMenu(),
        );
      }
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static const _screens = [
    Overview(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
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
