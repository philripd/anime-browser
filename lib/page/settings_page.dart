import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_for_anilist/provider/theme_provider.dart';

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
          children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'Theme: ',
                      style: Theme.of(context).textTheme.headline6,
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
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'dark',
                          child: Text(
                            'Dark',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'system',
                          child: Text(
                            'System',
                            style: Theme.of(context).textTheme.headline6,
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
