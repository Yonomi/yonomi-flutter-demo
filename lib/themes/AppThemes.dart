import 'package:flutter/material.dart';

import 'ColorConstants.dart';

class AppThemes {
  static const Color _primaryColor = ColorConstants.yonomiYellow;

  static const Color _bottomAppBarColor = ColorConstants.darkerBackground;

  static const Color _scaffoldBgColor = ColorConstants.darkestBackground;

  static const Color _buttonColors = ColorConstants.yonomiYellow;

  static const Color bottomAppBackgroundColor = ColorConstants.darkerBackground;

  static const Color bottomAppBarUnselectedItemColor =
      ColorConstants.lightGreyColor;

  static const Color bottomAppBarSelectedItemColor =
      ColorConstants.yonomiYellow;

  static const Color appBarBackgroundColor = ColorConstants.transparent;

  static const Color appBarTextColor = ColorConstants.yonomiYellow;

  static const Color listViewBackgroundColor = Colors.white;

  static const Color listViewTextColor = ColorConstants.darkGreyColor;

  static const Color listViewSeparatorColor = ColorConstants.lighterGreyColor;

  static ThemeData getMainTheme(BuildContext context) {
    return ThemeData(
        primaryColor: _primaryColor,
        bottomAppBarColor: _bottomAppBarColor,
        scaffoldBackgroundColor: _scaffoldBgColor,
        primarySwatch: createMaterialColor(_primaryColor),
        colorScheme: ColorScheme.dark(),
        appBarTheme: getAppBarTheme(context),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: _buttonColors,
        ));
  }

  static AppBarTheme getAppBarTheme(BuildContext context) {
    return AppBarTheme(
      color: Colors.transparent,
      textTheme: Theme.of(context).textTheme.copyWith(
              headline6: TextStyle(
            color: appBarTextColor,
            fontSize: 24.0,
          )),
    );
  }

  // Create a ColorSwatch from a single Color
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
