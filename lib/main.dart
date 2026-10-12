import 'package:flutter/material.dart';
import 'navigation/main_navigation.dart';
import 'screens/convert_screen.dart';
import 'screens/watchlist_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const FXPulseApp());

class FXPulseApp extends StatelessWidget {
  const FXPulseApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FXPulse',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    initialRoute: '/',
    routes: {
      '/': (context) => const MainNavigation(),
      '/convert': (context) => const ConvertScreen(),
      '/watchlist': (context) => const WatchlistScreen(),
    },
  );
}
