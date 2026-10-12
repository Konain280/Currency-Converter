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
  @override
  Widget build(BuildContext context) => ListView(
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
                const Text(
                  '0.9214',
                  style: TextStyle(
                    fontSize: 29,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                    color: ink,
                  ),
                ),
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
                  child: const Text(
                    '↗ +0.0038 (+0.41%)',
                    style: TextStyle(
                      fontSize: 10,
                      color: green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Text(
                  '1 EUR = 1.0853 USD',
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                    letterSpacing: .4,
                  ),
                ),
                Spacer(),
                Text(
                  'Past 30 days',
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
                  for (final p in ['7D', '1M', '3M', '1Y', 'All'])
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
            const SizedBox(height: 190, child: TrendChart()),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Apr 20', style: TextStyle(color: muted, fontSize: 11)),
                Text('Apr 28', style: TextStyle(color: muted, fontSize: 11)),
                Text('May 06', style: TextStyle(color: muted, fontSize: 11)),
                Text(
                  'May 14',
                  style: TextStyle(
                    color: blue,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('May 20', style: TextStyle(color: muted, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
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
  const TrendChart({super.key});
  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _TrendPainter(), child: const SizedBox.expand());
}

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, .72),
      Offset(.12, .65),
      Offset(.25, .77),
      Offset(.38, .56),
      Offset(.50, .61),
      Offset(.62, .35),
      Offset(.75, .15),
      Offset(.86, .20),
      Offset(.94, .42),
      Offset(1, .33),
    ].map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();
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
    final selected = points[6];
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
    for (final i in [2, 4, 5, 6, 9]) {
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
      text: const TextSpan(
        text: 'May 14  0.9248 EUR',
        style: TextStyle(
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}