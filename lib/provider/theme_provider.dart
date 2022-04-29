import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'system';

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _prefs.getString('theme') ?? 'system';
    notifyListeners();
  }

  ThemeMode get themeMode {
    switch(currentTheme) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }
}

class Themes {
  static final darkTheme = ThemeData(
    appBarTheme: _appBarTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade900,
      selectedItemColor: Colors.blue.shade600,
    ),
    colorScheme: const ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    appBarTheme: _appBarTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade300,
      selectedItemColor: Colors.blue.shade600,
    ),
    colorScheme: const ColorScheme.light(),
  );

  static final _appBarTheme = AppBarTheme(
    color: Colors.blue.shade600,
    titleSpacing: 24,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
