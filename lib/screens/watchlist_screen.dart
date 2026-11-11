import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/spark_painter.dart';

class _Currency {
  const _Currency({
    required this.flag,
    required this.code,
    required this.name,
    required this.rate,
    required this.change,
    required this.isPositive,
    required this.region,
    this.isMajor = false,
  });

  final String flag;
  final String code;
  final String name;
  final String rate;
  final String change;
  final bool isPositive;
  final String region;
  final bool isMajor;
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  String filter = 'All';
  String searchQuery = '';
  final Set<String> favorites = {'EUR', 'JPY'};

  // Static sample data keeps this screen fully local for the frontend demo.
  static const List<_Currency> currencies = [
    _Currency(
      flag: '🇪🇺',
      code: 'EUR',
      name: 'Euro',
      rate: '0.9214',
      change: '+0.32%',
      isPositive: true,
      region: 'Europe',
      isMajor: true,
    ),
    _Currency(
      flag: '🇬🇧',
      code: 'GBP',
      name: 'British Pound',
      rate: '0.7872',
      change: '+0.18%',
      isPositive: true,
      region: 'Europe',
      isMajor: true,
    ),
    _Currency(
      flag: '🇨🇭',
      code: 'CHF',
      name: 'Swiss Franc',
      rate: '0.8951',
      change: '+0.09%',
      isPositive: true,
      region: 'Europe',
      isMajor: true,
    ),
    _Currency(
      flag: '🇯🇵',
      code: 'JPY',
      name: 'Japanese Yen',
      rate: '149.82',
      change: '-0.24%',
      isPositive: false,
      region: 'Asia-Pacific',
      isMajor: true,
    ),
    _Currency(
      flag: '🇨🇳',
      code: 'CNY',
      name: 'Chinese Yuan',
      rate: '7.24',
      change: '+0.11%',
      isPositive: true,
      region: 'Asia-Pacific',
    ),
    _Currency(
      flag: '🇮🇳',
      code: 'INR',
      name: 'Indian Rupee',
      rate: '83.42',
      change: '+0.07%',
      isPositive: true,
      region: 'Asia-Pacific',
    ),
    _Currency(
      flag: '🇦🇺',
      code: 'AUD',
      name: 'Australian Dollar',
      rate: '1.5120',
      change: '-0.15%',
      isPositive: false,
      region: 'Asia-Pacific',
      isMajor: true,
    ),
    _Currency(
      flag: '🇨🇦',
      code: 'CAD',
      name: 'Canadian Dollar',
      rate: '1.3651',
      change: '-0.11%',
      isPositive: false,
      region: 'Americas',
      isMajor: true,
    ),
    _Currency(
      flag: '🇳🇿',
      code: 'NZD',
      name: 'New Zealand Dollar',
      rate: '1.6470',
      change: '+0.05%',
      isPositive: true,
      region: 'Asia-Pacific',
    ),
    _Currency(
      flag: '🇵🇰',
      code: 'PKR',
      name: 'Pakistani Rupee',
      rate: '278.00',
      change: '-0.08%',
      isPositive: false,
      region: 'Asia-Pacific',
    ),
    _Currency(
      flag: '🇸🇬',
      code: 'SGD',
      name: 'Singapore Dollar',
      rate: '1.3420',
      change: '+0.12%',
      isPositive: true,
      region: 'Asia-Pacific',
    ),
    _Currency(
      flag: '🇲🇽',
      code: 'MXN',
      name: 'Mexican Peso',
      rate: '16.72',
      change: '+0.21%',
      isPositive: true,
      region: 'Americas',
    ),
  ];

  List<_Currency> get filteredCurrencies {
    final query = searchQuery.trim().toLowerCase();
    return currencies.where((currency) {
      final matchesSearch =
          query.isEmpty ||
          currency.code.toLowerCase().contains(query) ||
          currency.name.toLowerCase().contains(query);
      final matchesFilter = switch (filter) {
        'Favorites' => favorites.contains(currency.code),
        'Majors' => currency.isMajor,
        'Europe' => currency.region == 'Europe',
        'Asia-Pacific' => currency.region == 'Asia-Pacific',
        _ => true,
      };
      return matchesSearch && matchesFilter;
    }).toList();
  }

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
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search by currency name or code...',
                hintStyle: const TextStyle(fontSize: 12, color: muted),
                prefixIcon: const Icon(Icons.search_rounded, color: muted),
                suffixIcon: searchQuery.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        onPressed: () => setState(() => searchQuery = ''),
                        icon: const Icon(Icons.close_rounded, color: muted),
                      ),
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
                          (value) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(
                                value == 'Favorites'
                                    ? 'Favorites (${favorites.length})'
                                    : value,
                              ),
                              selected: filter == value,
                              onSelected: (_) => setState(() => filter = value),
                              showCheckmark: false,
                              selectedColor: const Color(0xFFDDF1E9),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: filter == value ? green : muted,
                              ),
                              side: BorderSide(
                                color: filter == value
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
                    'Favorite pairs vs USD',
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
                  child: Text(
                    '${favorites.length}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (filteredCurrencies.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Column(
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 34,
                      color: muted,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      filter == 'Favorites' && favorites.isEmpty
                          ? 'No favorite currencies yet. Tap a star to add one.'
                          : 'No currencies match your search.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: muted, fontSize: 13),
                    ),
                  ],
                ),
              )
            else
              ...filteredCurrencies.map(_currencyRow),
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
                  Icon(Icons.info_outline_rounded, color: green, size: 19),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Rates are sample values for this frontend demonstration.',
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

  Widget _currencyRow(_Currency currency) {
    final isFavorite = favorites.contains(currency.code);
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        child: Row(
          children: [
            Text(currency.flag, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    currency.name,
                    style: const TextStyle(color: muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 58,
              height: 28,
              child: CustomPaint(
                painter: SparkPainter(positive: currency.isPositive),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currency.rate,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currency.change,
                  style: TextStyle(
                    color: currency.isPositive
                        ? green
                        : const Color(0xFFD65C5C),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            IconButton(
              tooltip: isFavorite
                  ? 'Remove from favorites'
                  : 'Add to favorites',
              visualDensity: VisualDensity.compact,
              onPressed: () => setState(() {
                if (isFavorite) {
                  favorites.remove(currency.code);
                } else {
                  favorites.add(currency.code);
                }
              }),
              icon: Icon(
                isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                color: isFavorite ? const Color(0xFFE9AD41) : muted,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
