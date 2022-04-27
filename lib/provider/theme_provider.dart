import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Themes {
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.lightBlue.shade600,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.lightBlue.shade600,
    ),
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: Colors.grey.shade900,
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        color: Colors.lightBlue.shade600,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade300,
      selectedItemColor: Colors.lightBlue.shade600,
    ),
    colorScheme: const ColorScheme.light(),
  );
}
