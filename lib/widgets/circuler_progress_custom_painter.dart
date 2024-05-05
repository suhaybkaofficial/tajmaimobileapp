import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressCustomPainter extends CustomPainter {
  final double currentProgress;
  final Color backgroundColor;
  final Color progressColor;
  CircleProgressCustomPainter({
    required this.currentProgress,
    this.backgroundColor = Colors.white,
    this.progressColor = Colors.redAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 3
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 3
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
