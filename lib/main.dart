import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/ui/app.dart';
import 'package:animebrowser/ui/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDependencies();
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: initializeBlocs(mainAppWidget: const App()),
  ));
}
