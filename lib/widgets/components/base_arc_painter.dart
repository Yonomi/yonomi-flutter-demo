import 'dart:math';

import 'package:flutter/widgets.dart';

import 'slider_component.dart';

const double ARC_START_ANGLE = pi / 2 + pi / 10;
const double ARC_SWEEP_ANGLE = 2 * pi - pi / 5;

class BaseArcPainter extends CustomPainter {
  SliderMode mode;

  Color arcColor;

  Offset center;

  double radius;

  double startAngle = 0;
  double sweepAngle = 0;

  double strokeWidth;

  BaseArcPainter(
      {@required this.mode,
      @required this.arcColor,
      @required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = _getPaint(arcColor, PaintingStyle.stroke);

    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2) - strokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        ARC_START_ANGLE, ARC_SWEEP_ANGLE, false, painter);
  }

  Paint _getPaint(@required color, PaintingStyle style) => Paint()
    ..color = color
    ..style = style ?? PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = this.strokeWidth;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
