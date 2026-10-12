import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

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
