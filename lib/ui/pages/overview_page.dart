import 'package:animebrowser/ui/widgets/seasonal_anime_list.dart';
import 'package:animebrowser/utils/helpers/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        title: Text(
          toBeginningOfSentenceCase(getCurrentSeason().toLowerCase())!
          + " " + getCurrentSeasonYear().toString()  + " Overview"
        )
      ),
      body: const SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: SeasonalAnimeList(),
      ),
    );
  }
}
