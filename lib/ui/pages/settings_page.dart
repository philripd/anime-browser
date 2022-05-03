import 'package:anilistbrowser/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  static const BottomNavigationBarItem navItem = BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
  );

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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    'Theme:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    ),
                  ),
                ),
                Consumer<ThemeProvider>(
                  builder: (context, provider, child) {
                  return DropdownButton(
                    alignment: Alignment.center,
                    value: provider.currentTheme,
                    items: [
                      DropdownMenuItem(
                        value: 'light',
                        child: Text(
                          'Light',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'dark',
                        child: Text(
                          'Dark',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'system',
                        child: Text(
                          'System',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (String? value) {
                      provider.changeTheme(value ?? 'system');
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
