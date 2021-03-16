import 'dart:math';

import 'package:flutter/material.dart';

class Arc extends StatefulWidget {
  final Widget centerWidget;
  final Color color;
  final void Function(double) onFinalSetPoint;
  final double maxValue;

  double value;

  Arc(
      {Key key,
      @required this.centerWidget,
      this.color,
      @required initialValue,
      @required this.onFinalSetPoint,
      @required this.maxValue})
      : super(key: key) {
    value = initialValue;
  }

  @override
  _ArcState createState() => _ArcState();
}

class _ArcState extends State<Arc> {
  double _thumbx = 0;
  double _thumby = 0;

  @override
  void initState() {
    super.initState();
    print(widget.value);
    _thumbx = (150 *
            cos(pi / 2 +
                pi / 10 +
                (2 * pi - pi / 5) / widget.maxValue * widget.value)) +
        150 -
        5;
    _thumby = (150 *
            sin(pi / 2 +
                pi / 10 +
                (2 * pi - pi / 5) / widget.maxValue * widget.value)) +
        150 -
        5;
  }

  double calculateValue() {
    final atanResult = atan2(_thumby - 145, _thumbx - 145) - 3 * pi / 5;
    final atanFrom0to2pi =
        (atanResult <= 0) ? (2 * pi + atanResult) : atanResult;
    // final atanFrom0to2pi = atanResult.abs();
    return (5 * widget.maxValue * (atanFrom0to2pi) / (9 * pi));
  }

  @override
  Widget build(BuildContext context) {
    final width = 300.0;
    final height = 300.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              setState(() {
                final dx = details.localPosition.dx;
                final dy = details.localPosition.dy;
                compensateDragCoordinates(dx, dy, width);
              });
            },
            onPanEnd: (DragEndDetails details) {
              widget.onFinalSetPoint(calculateValue());
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                final dx = details.localPosition.dx;
                final dy = details.localPosition.dy;
                compensateDragCoordinates(dx, dy, width);
              });
            },
            onTapUp: (TapUpDetails details) {
              widget.onFinalSetPoint(calculateValue());
            },
            child: CustomPaint(
              painter:
                  OpenPainter(widget.color, width, height, _thumbx, _thumby),
            ),
          ),
        ),
        LayoutBuilder(
            builder: (_, constraints) => Container(
                  width: width,
                  height: height,
                  child: Center(child: widget.centerWidget),
                )),
      ],
    );
  }

  void compensateDragCoordinates(double dx, double dy, double width) {
    if (dx > 0 && dy > 0 && dx < 300 && dy < 300) {
      final angle = atan(dy / dx);
      final A = width / 2 * (sin(angle) + cos(angle));
      final B = width / 2 * sqrt(2 * sin(angle) * cos(angle));
      final R1 = A + B;
      final R2 = A - B;
      final R = sqrt(dx * dx + dy * dy);
      final dr1 = (R - R1).abs();
      final dr2 = (R - R2).abs();
      if (dr1 < dr2) {
        _thumbx = R1 * cos(angle) - 5;
        _thumby = R1 * sin(angle) - 5;
      } else {
        _thumbx = R2 * cos(angle) - 5;
        _thumby = R2 * sin(angle) - 5;
      }
    }
  }
}

class OpenPainter extends CustomPainter {
  final Color color;
  final double width;
  final double height;
  final double thumbx;
  final double thumby;

  OpenPainter(this.color, this.width, this.height, this.thumbx, this.thumby);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color ?? Color(0xff63aa65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    var paint2 = Paint()
      ..color = Colors.red[400]
      ..style = PaintingStyle.fill;
    //draw arc
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(width / 2, height / 2), radius: width / 2),
        pi / 2 + pi / 10, //radians
        2 * pi - pi / 5, //radians
        false,
        paint1);
    canvas.drawCircle(Offset(thumbx + 5, thumby + 5), 10, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
