import 'package:flutter/material.dart';

import 'app_colors.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: canvas,
  colorScheme: ColorScheme.fromSeed(
    seedColor: blue,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: canvas,
    foregroundColor: ink,
    elevation: 0,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    height: 64,
    backgroundColor: Color(0xFFF8F9FF),
    indicatorColor: Color(0xFFE7EDFF),
    labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 11)),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: ink),
    titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w700),
  ),
);
