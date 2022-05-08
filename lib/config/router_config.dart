import 'package:animebrowser/ui/pages/media_details_page.dart';
import 'package:flutter/material.dart';

typedef RoutesMap = Map<String, WidgetBuilder>;

final RoutesMap appRoutes = {
  DetailsPage.routeName: (_) => const DetailsPage(),
};
