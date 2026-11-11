import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/app_header.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});
  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  String period = '1M';
  static const _history = <String, _PeriodData>{
    '1D': _PeriodData(
      rate: '0.9231', change: '+0.0017 (+0.18%)', inverse: '1.0833',
      caption: 'Past 24 hours', dates: ['09:00', '12:00', '15:00', '18:00', 'Now'],
      tooltip: 'Now  0.9231 EUR', values: [.72, .63, .70, .50, .57, .38, .47, .26, .35, .20],
      selectedIndex: 9,
    ),
    '1W': _PeriodData(
      rate: '0.9226', change: '+0.0012 (+0.13%)', inverse: '1.0839',
      caption: 'Past 7 days', dates: ['May 14', 'May 16', 'May 18', 'May 19', 'May 20'],
      tooltip: 'May 20  0.9226 EUR', values: [.79, .68, .75, .50, .56, .34, .43, .18, .31, .27],
      selectedIndex: 8,
    ),
    '1M': _PeriodData(
      rate: '0.9214', change: '+0.0038 (+0.41%)', inverse: '1.0853',
      caption: 'Past 30 days', dates: ['Apr 20', 'Apr 28', 'May 06', 'May 14', 'May 20'],
      tooltip: 'May 14  0.9248 EUR', values: [.72, .65, .77, .56, .61, .35, .15, .20, .42, .33],
      selectedIndex: 6,
    ),
  };
  @override
  Widget build(BuildContext context) {
    final data = _history[period]!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      children: [
        const AppHeader(),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🇺🇸 🇪🇺', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 9),
                  const Text(
                    'USD / EUR',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.swap_horiz, color: muted),
                  const Spacer(),
                  _roundIcon(Icons.bookmark_border_rounded),
                ],
              ),
              const SizedBox(height: 11),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: Text(
                        data.rate,
                        key: ValueKey(data.rate),
                        style: TextStyle(
                          fontSize: 29,
                          height: 1,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                          color: ink,
                        ),
                      )),
                  const SizedBox(width: 8),
                  const Text(
                    'EUR',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF41465A),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2F8EC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          '↗ ${data.change}',
                          key: ValueKey(data.change),
                          style: TextStyle(
                            fontSize: 10,
                            color: green,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '1 EUR = ${data.inverse} USD',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12,
                      letterSpacing: .4,
                    ),
                  ),
                  Spacer(),
                  Text(
                    data.caption,
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 36,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F3FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    for (final p in ['1D', '1W', '1M'])
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => period = p),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: period == p ? blue : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              p,
                              style: TextStyle(
                                color: period == p
                                    ? Colors.white
                                    : const Color(0xFF43485A),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: blue),
                  const SizedBox(width: 8),
                  const Text(
                    'HISTORICAL TREND',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: .4,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'ECB Reference · Close',
                    style: TextStyle(fontSize: 11, color: muted),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 190,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: TrendChart(key: ValueKey(period), data: data),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [for (var i = 0; i < data.dates.length; i++)
                  Text(data.dates[i], style: TextStyle(color: i == 3 ? blue : muted,
                      fontSize: 11, fontWeight: i == 3 ? FontWeight.w700 : FontWeight.normal))],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PeriodData {
  const _PeriodData({required this.rate, required this.change, required this.inverse,
    required this.caption, required this.dates, required this.tooltip,
    required this.values, required this.selectedIndex});
  final String rate, change, inverse, caption, tooltip;
  final List<String> dates;
  final List<double> values;
  final int selectedIndex;
}

BoxDecoration _cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(14),
  boxShadow: const [
    BoxShadow(color: Color(0x08001B55), blurRadius: 5, offset: Offset(0, 2)),
  ],
);
Widget _roundIcon(IconData icon) => Container(
  width: 36,
  height: 36,
  decoration: const BoxDecoration(
    color: Color(0xFFE8EFFF),
    shape: BoxShape.circle,
  ),
  child: Icon(icon, size: 20, color: const Color(0xFF38465E)),
);

class TrendChart extends StatelessWidget {
  const TrendChart({super.key, required this.data});
  final _PeriodData data;
  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _TrendPainter(data), child: const SizedBox.expand());
}

class _TrendPainter extends CustomPainter {
  _TrendPainter(this.data);
  final _PeriodData data;
  @override
  void paint(Canvas canvas, Size size) {
    // Values are normalized (0–1): x spreads evenly across width; y scales by
    // height, where 0 is the top and 1 the bottom of the canvas.
    final points = data.values.asMap().entries.map((entry) => Offset(
      size.width * entry.key / (data.values.length - 1),
      size.height * entry.value,
    )).toList();
    final grid = Paint()
      ..color = const Color(0xFFE4E9F4)
      ..strokeWidth = 1;
    for (final y in [.18, .47, .76]) {
      var x = 0.0;
      while (x < size.width) {
        canvas.drawLine(
          Offset(x, y * size.height),
          Offset((x + 3).clamp(0, size.width), y * size.height),
          grid,
        );
        x += 6;
      }
    }
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final mid = (points[i - 1].dx + points[i].dx) / 2;
      path.cubicTo(
        mid,
        points[i - 1].dy,
        mid,
        points[i].dy,
        points[i].dx,
        points[i].dy,
      );
    }
    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x333D7BF6), Color(0x00FFFFFF)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = blue
        ..strokeWidth = 2.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
    final selected = points[data.selectedIndex];
    final dash = Paint()
      ..color = const Color(0xFF72A2FF)
      ..strokeWidth = 1.2;
    var y = selected.dy;
    while (y < size.height) {
      canvas.drawLine(
        Offset(selected.dx, y),
        Offset(selected.dx, (y + 3).clamp(0, size.height)),
        dash,
      );
      y += 6;
    }
    for (final i in {2, 4, 5, data.selectedIndex, 9}) {
      canvas.drawCircle(points[i], 3, Paint()..color = Colors.white);
      canvas.drawCircle(
        points[i],
        3,
        Paint()
          ..color = blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
    final label = TextPainter(
      text: TextSpan(
        text: data.tooltip,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final rect = Rect.fromLTWH(
      (selected.dx - label.width / 2).clamp(0, size.width - label.width),
      selected.dy - 44,
      label.width + 16,
      24,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      Paint()..color = const Color(0xFF223044),
    );
    label.paint(canvas, Offset(rect.left + 8, rect.top + 5));
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) => oldDelegate.data != data;
}