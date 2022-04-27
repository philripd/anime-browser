import 'package:flutter/material.dart';
import 'package:stats_for_anilist/widget/theme_toggle_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            Text(
              'Index 1: Settings',
              textAlign: TextAlign.center,
            ),
            Text(
              'Toggle Dark Theme',
              textAlign: TextAlign.center,
            ),
            ThemeToggleWidget(),
          ],
        ),
      ),
    );
  }
}
