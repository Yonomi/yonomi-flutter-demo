import 'package:flutter/material.dart';

import 'ColorConstants.dart';

class AppThemes {
  static const Color _primaryColor = ColorConstants.yonomiYellow;

  static const Color _bottomAppBarColor = ColorConstants.darkBackground;

  static ThemeData get MainTheme {
    return ThemeData(
      primaryColor: _primaryColor,
      bottomAppBarColor: _bottomAppBarColor,
      appBarTheme: appBarTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      color: _primaryColor,
    );
  }
}
