import 'package:flutter/material.dart';

import '../screens/convert_screen.dart';
import '../screens/watchlist_screen.dart';
import '../screens/trends_screen.dart';
import '../screens/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: IndexedStack(
        index: index,
        children: const [
          ConvertScreen(),
          WatchlistScreen(),
          TrendsScreen(),
          SettingsScreen(),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (value) => setState(() => index = value),
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFE7EDFF),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.swap_horiz_rounded),
          label: 'Convert',
        ),
        NavigationDestination(
          icon: Icon(Icons.star_outline_rounded),
          selectedIcon: Icon(Icons.star_rounded),
          label: 'Watchlist',
        ),
        NavigationDestination(
          icon: Icon(Icons.show_chart_rounded),
          selectedIcon: Icon(Icons.show_chart_rounded),
          label: 'Trends',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings_rounded),
          label: 'Settings',
        ),
      ],
    ),
  );
}
