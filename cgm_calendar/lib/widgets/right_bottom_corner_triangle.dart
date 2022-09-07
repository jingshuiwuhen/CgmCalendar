import 'package:flutter/material.dart';

class RightBottomCornerTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.red;

    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width * 2 / 3, size.height);
    path.lineTo(size.width, size.height - size.width / 3);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
