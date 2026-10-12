import 'package:flutter/material.dart';
import 'app_colors.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: canvas,
  colorScheme: ColorScheme.fromSeed(seedColor: green, brightness: Brightness.light),
  appBarTheme: const AppBarTheme(backgroundColor: canvas, foregroundColor: ink, elevation: 0),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: ink),
    titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w700),
  ),
);
