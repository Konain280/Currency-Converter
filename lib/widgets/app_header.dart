import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: ink,
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Icon(
          Icons.currency_exchange_rounded,
          color: Color(0xFF11D2AA),
          size: 20,
        ),
      ),
      const SizedBox(width: 9),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FXPulse',
              style: TextStyle(
                fontSize: 17,
                height: 1,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.circle, size: 7, color: green),
                SizedBox(width: 5),
                Text(
                  'Frankfurter API · Synced',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1,
                    color: green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      IconButton(
        onPressed: () {},
        visualDensity: VisualDensity.compact,
        icon: const Icon(Icons.sync_rounded, size: 20, color: ink),
      ),
      const CircleAvatar(
        radius: 16,
        backgroundColor: blue,
        child: Icon(
          Icons.person_outline_rounded,
          size: 19,
          color: Colors.white,
        ),
      ),
    ],
  );
}
