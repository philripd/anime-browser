import 'package:anilist_browser/provider/theme_provider.dart';
import 'package:anilist_browser/ui/themes/app_theme.dart';
import 'package:anilist_browser/ui/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'AniList Browser',
            themeMode: provider.themeMode,
            theme: lightAppTheme(context),
            darkTheme: darkAppTheme(context),
            home: const BottomNavigation(),
          );
        }
    );
  }
}
