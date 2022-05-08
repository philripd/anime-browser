import 'package:animebrowser/ui/widgets/seasonal_anime_list.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  static const BottomNavigationBarItem navItem = BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Overview',
  );

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
      ),
      body: const SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16.0),
        child: SeasonalAnimeList(),
      ),
    );
  }
}
