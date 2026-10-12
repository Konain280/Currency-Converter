import 'package:flutter/material.dart';

const ink = Color(0xFF172A3A);
const muted = Color(0xFF7C8A96);
const green = Color(0xFF158B68);
const canvas = Color(0xFFF5F8F8);

void main() => runApp(const FXPulseApp());

class FXPulseApp extends StatelessWidget {
  const FXPulseApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FXPulse',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: green,
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
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: ink),
        titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w700),
      ),
    ),
    home: const MainNavigation(),
  );
}

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
        children: const [ConvertScreen(), WatchlistScreen()],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (value) => setState(() => index = value),
      backgroundColor: Colors.white,
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
      ],
    ),
  );
}

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});
  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  String amount = '1,000.00';
  String activeCode = 'USD';
  void key(String value) => setState(() {
    if (value == '⌫') {
      if (amount.isNotEmpty) {
        amount = amount.substring(0, amount.length - 1);
      }
    } else if (value == 'Clear') {
      amount = '';
    } else if (value == '.') {
      if (!amount.contains('.')) amount += '.';
    } else if (value == 'Max') {
      amount = '12,450.00';
    } else if (value.startsWith('+\$')) {
      amount =
          ((double.tryParse(amount.replaceAll(',', '')) ?? 0) +
                  double.parse(value.substring(2)))
              .toStringAsFixed(2);
    } else {
      amount += value;
    }
  });

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Row(
              children: [
                const Text(
                  'FXPulse',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ink,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F5EF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, size: 7, color: green),
                      SizedBox(width: 6),
                      Text(
                        'Frankfurter API · Synced',
                        style: TextStyle(
                          fontSize: 10,
                          color: green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh_rounded, color: muted),
                ),
                const CircleAvatar(
                  radius: 17,
                  backgroundColor: Color(0xFFDCEBE7),
                  child: Icon(Icons.person_rounded, color: green, size: 19),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 18,
                    color: green,
                  ),
                  SizedBox(width: 9),
                  Text(
                    'Base currency',
                    style: TextStyle(color: muted, fontSize: 13),
                  ),
                  Spacer(),
                  Text(
                    'Base: USD (\$)',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ink,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _currencyCard(
              title: 'YOU SEND',
              code: activeCode,
              flag: '🇺🇸',
              amount: amount,
              showBalance: true,
              onCurrency: (v) => setState(() => activeCode = v),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 9, 9, 9),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3F1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_flat_rounded,
                      size: 17,
                      color: green,
                    ),
                    const SizedBox(width: 7),
                    const Text(
                      '1 USD = 0.9214 EUR',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ink,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => setState(
                        () => activeCode = activeCode == 'USD' ? 'EUR' : 'USD',
                      ),
                      borderRadius: BorderRadius.circular(20),
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.swap_vert_rounded,
                          size: 18,
                          color: green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _currencyCard(
              title: 'THEY RECEIVE',
              code: 'EUR',
              flag: '🇪🇺',
              amount: '921.40',
              showBalance: false,
              onCurrency: (_) {},
              instant: true,
            ),
            const SizedBox(height: 13),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['+\$10', '+\$50', '+\$100', '+\$500', 'Max']
                    .map(
                      (v) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(
                            v,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: ink,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () => key(v),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),
            _marketCard(),
            const SizedBox(height: 14),
            _keypad(),
          ]),
        ),
      ),
    ],
  );

  Widget _currencyCard({
    required String title,
    required String code,
    required String flag,
    required String amount,
    required bool showBalance,
    required ValueChanged<String> onCurrency,
    bool instant = false,
  }) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.2,
                  color: muted,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              if (instant)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F5EE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '⚡ Instant',
                    style: TextStyle(
                      color: green,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              InkWell(
                onTap: () => onCurrency(code == 'USD' ? 'EUR' : 'USD'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: canvas,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(flag, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 7),
                      Text(
                        code,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 19,
                        color: muted,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  amount,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: showBalance ? 26 : 29,
                    fontWeight: FontWeight.w700,
                    color: ink,
                    letterSpacing: -.6,
                  ),
                ),
              ),
            ],
          ),
          if (showBalance) ...[
            const SizedBox(height: 13),
            const Divider(height: 1),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text('Balance', style: TextStyle(color: muted, fontSize: 11)),
                Spacer(),
                Text(
                  'Avail: \$12,450.00',
                  style: TextStyle(
                    color: muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    ),
  );

  Widget _marketCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '24h Market Trend',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F5EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+0.32%',
                  style: TextStyle(
                    color: green,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          const SizedBox(
            height: 39,
            width: double.infinity,
            child: CustomPaint(painter: SparkPainter()),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                'Mid-Market Rate',
                style: TextStyle(color: muted, fontSize: 10),
              ),
              Spacer(),
              Text(
                'Updated just now',
                style: TextStyle(color: muted, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _keypad() => Card(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Enter amount',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => key('Clear'),
                child: const Text('Clear', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          for (final row in [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
            ['.', '0', '⌫'],
          ])
            Row(
              children: row
                  .map(
                    (v) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: SizedBox(
                          height: 37,
                          child: OutlinedButton(
                            onPressed: () => key(v),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade200),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: v == '⌫'
                                ? const Icon(Icons.backspace_outlined, size: 17)
                                : Text(
                                    v,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    ),
  );
}

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

class SparkPainter extends CustomPainter {
  const SparkPainter({this.positive = true});
  final bool positive;
  @override
  void paint(Canvas canvas, Size size) {
    final points = positive
        ? const [0.75, 0.63, 0.69, 0.42, 0.48, 0.25, 0.38, 0.16, 0.22, 0.08]
        : const [0.16, 0.29, 0.23, 0.47, 0.38, 0.58, 0.54, 0.76, 0.65, 0.84];
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final p = Offset(
        size.width * i / (points.length - 1),
        size.height * points[i],
      );
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    final paint = Paint()
      ..color = positive ? green : const Color(0xFFD65C5C)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SparkPainter oldDelegate) =>
      positive != oldDelegate.positive;
}
