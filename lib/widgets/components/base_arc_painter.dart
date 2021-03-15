import 'dart:math';

import 'package:flutter/widgets.dart';

import 'slider_component.dart';

const double ARC_START_ANGLE = pi / 2 + pi / 10;
const double ARC_SWEEP_ANGLE = 2 * pi - pi / 5;

class BaseArcPainter extends CustomPainter {
  SliderMode mode;

  Color arcColorStart, arcColorEnd;

  Offset center;

  double radius;

  double startAngle = 0;
  double sweepAngle = 0;

  double strokeWidth;

  Shader _sweepGradientShader;

  BaseArcPainter(
      {@required this.mode,
      @required this.arcColorStart,
      this.arcColorEnd,
      @required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerWidth = size.width / 2;
    final double centerHeight = size.height / 2;

    Paint painter = _getPaint(arcColorStart, PaintingStyle.stroke,
        Rect.fromCircle(center: Offset(centerWidth, centerHeight), radius: 0));

    center = Offset(centerWidth, centerHeight);
    radius = min(centerWidth, centerHeight) - strokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        ARC_START_ANGLE, ARC_SWEEP_ANGLE, false, painter);
  }

  Paint _getPaint(@required color, PaintingStyle style, Rect offset) {
    Paint painter = Paint()
      ..color = color
      ..style = style ?? PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = this.strokeWidth;

    if (arcColorStart != null && arcColorEnd != null) {
      painter..shader = this.sweepGradientShader(offset);
    }

    return painter;
  }

  Shader sweepGradientShader(Rect offset) {
    return this._sweepGradientShader ??=
        SweepGradient(colors: [arcColorStart, arcColorEnd])
            .createShader(offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
