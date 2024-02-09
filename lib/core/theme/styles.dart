import 'package:flutter/material.dart';
import 'package:shop/core/theme/colors.dart';
import 'package:shop/core/utils/custom_route.dart';

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
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CustomTransitionsBuilder(),
            TargetPlatform.android: CustomTransitionsBuilder(),
          }
        ),
      );
}
