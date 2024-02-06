import 'package:flutter/material.dart';
import 'package:shop/core/theme/colors.dart';

class Styles {
  static ThemeData setMaterial3Theme() => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: colorPrimary,
          secondary: colorSecondary,
          error: colorError,
          background: colorBackground,
          onBackground: colorOnBackground,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: colorPrimary,
          foregroundColor: colorOnPrimary,
        ),
        fontFamily: 'Lato',
      );
}
