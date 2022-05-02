import 'package:anilist_browser/provider/theme_provider.dart';
import 'package:anilist_browser/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const App(),
  ));
}
