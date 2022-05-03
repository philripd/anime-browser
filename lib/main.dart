import 'package:anilistbrowser/provider/theme_provider.dart';
import 'package:anilistbrowser/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const App(),
  ));
}
