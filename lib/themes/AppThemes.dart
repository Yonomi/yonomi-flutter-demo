import 'package:flutter/material.dart';

import 'ColorConstants.dart';

class AppThemes {
  static const Color _primaryColor = ColorConstants.yonomiYellow;

  static const Color _bottomAppBarColor = ColorConstants.lighterDarkBackground;

  static const Color _scaffoldBgColor = ColorConstants.darkBackground;

  static const Color _buttonColors = ColorConstants.yonomiYellow;

  static const Color bottomAppBackgroundColor =
      ColorConstants.lighterDarkBackground;

  static const Color bottomAppBarUnselectedItemColor =
      ColorConstants.lightGreyTextColor;

  static const Color bottomAppBarSelectedItemColor =
      ColorConstants.yonomiYellow;

  static ThemeData get MainTheme {
    return ThemeData(
        primaryColor: _primaryColor,
        bottomAppBarColor: _bottomAppBarColor,
        scaffoldBackgroundColor: _scaffoldBgColor,
        primarySwatch: createMaterialColor(_primaryColor),
        textTheme: defaultTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //3
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: _buttonColors,
        ));
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      color: _primaryColor,
    );
  }

  static const TextTheme defaultTextTheme = TextTheme(
    headline1: TextStyle(
        debugLabel: 'whiteMountainView headline1',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        debugLabel: 'whiteMountainView headline2',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        debugLabel: 'whiteMountainView headline3',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        debugLabel: 'whiteMountainView headline4',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        debugLabel: 'whiteMountainView headline5',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        debugLabel: 'whiteMountainView headline6',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        debugLabel: 'whiteMountainView bodyText1',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        debugLabel: 'whiteMountainView bodyText2',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        debugLabel: 'whiteMountainView subtitle1',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        debugLabel: 'whiteMountainView subtitle2',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    caption: TextStyle(
        debugLabel: 'whiteMountainView caption',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    button: TextStyle(
        debugLabel: 'whiteMountainView button',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    overline: TextStyle(
        debugLabel: 'whiteMountainView overline',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
  );

  // Creates a ColorSwatch from a single Color
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
