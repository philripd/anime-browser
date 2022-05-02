import 'package:anilist_browser/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightAppTheme(BuildContext context) => ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: colorProduct,
    background: colorBackgroundLight,
  ),
  textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
).copyWith(
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
    color: colorBackgroundLight,
    titleTextStyle:
      GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)
        .headline6
        ?.copyWith(color: Colors.black87),
    iconTheme: const IconThemeData(color: Colors.black87),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade200,
    selectedItemColor: colorProduct,
  ),
);

ThemeData darkAppTheme(BuildContext context) => ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: colorProduct,
    background: colorBackgroundDark,
  ),
  textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
).copyWith(
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
    color: colorBackgroundDark,
    titleTextStyle:
      GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)
        .headline6
        ?.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade900,
    selectedItemColor: colorProduct,
  ),
);
