import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/spark_painter.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  String filter = 'All';
  final Set<String> favorites = {'EUR', 'JPY'};
  final currencies = const [
    ['🇪🇺', 'EUR', 'Euro', '0.9214', '+0.32%', true],
    ['🇬🇧', 'GBP', 'British Pound', '0.7872', '+0.18%', true],
    ['🇯🇵', 'JPY', 'Japanese Yen', '149.82', '-0.24%', false],
    ['🇨🇦', 'CAD', 'Canadian Dollar', '1.3651', '-0.11%', false],
    ['🇮🇳', 'INR', 'Indian Rupee', '83.42', '+0.07%', true],
  ];
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            const Text(
              'Markets',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search 30+ world currencies (EUR, JPY)...',
                hintStyle: const TextStyle(fontSize: 12, color: muted),
                prefixIcon: const Icon(Icons.search_rounded, color: muted),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 13),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    ['All', 'Favorites', 'Majors', 'Europe', 'Asia-Pacific']
                        .map(
                          (v) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(v),
                              selected: filter == v,
                              onSelected: (_) => setState(() => filter = v),
                              showCheckmark: false,
                              selectedColor: const Color(0xFFDDF1E9),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: filter == v ? green : muted,
                              ),
                              side: BorderSide(
                                color: filter == v
                                    ? const Color(0xFFDDF1E9)
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 21),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Watchlist vs USD (\$)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '05',
                    style: TextStyle(
                      fontSize: 11,
                      color: ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('Add', style: TextStyle(fontSize: 11)),
                  style: FilledButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...currencies
                .where(
                  (row) => filter != 'Favorites' || favorites.contains(row[1]),
                )
                .map(_currencyRow),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3F1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.offline_pin_outlined, color: green, size: 19),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'All 32 rates cached locally in Room/SQLite. Valid offline.',
                      style: TextStyle(
                        color: ink,
                        fontSize: 11,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ],
  );

  Widget _currencyRow(List<dynamic> item) {
    final positive = item[5] as bool;
    final code = item[1] as String;
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        child: Row(
          children: [
            Text(item[0] as String, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item[2] as String,
                    style: const TextStyle(color: muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 58,
              height: 28,
              child: CustomPaint(painter: SparkPainter(positive: positive)),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item[3] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item[4] as String,
                  style: TextStyle(
                    color: positive ? green : const Color(0xFFD65C5C),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () => setState(
                () => favorites.contains(code)
                    ? favorites.remove(code)
                    : favorites.add(code),
              ),
              icon: Icon(
                favorites.contains(code)
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: favorites.contains(code)
                    ? const Color(0xFFE9AD41)
                    : muted,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
