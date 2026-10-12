import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/spark_painter.dart';

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
