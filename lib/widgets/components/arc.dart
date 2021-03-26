import 'dart:math';

import 'package:flutter/material.dart';

class Arc extends StatefulWidget {
  final Widget centerWidget;
  final Color color;
  final ValueChanged<double> onFinalSetPoint;
  final double maxValue;

  final double initialValue;

  Arc(
      {Key key,
      @required this.centerWidget,
      this.color,
      @required this.initialValue,
      @required this.onFinalSetPoint,
      @required this.maxValue})
      : super(key: key);

  @override
  _ArcState createState() => _ArcState();
}

class _ArcState extends State<Arc> {
  double _thumbx = 0;
  double _thumby = 0;
  double value = 0;

  @override
  void initState() {
    super.initState();
    calculateThumbxThumby();
  }

  void calculateThumbxThumby() {
    final xy = calculateXYFromMagnitude(widget.initialValue);
    _thumbx = xy['x'];
    _thumby = xy['y'];
    value = widget.initialValue;
  }

  Map calculateXYFromMagnitude(double magnitude) {
    final x = (150 *
            cos(pi / 2 +
                pi / 10 +
                (2 * pi - pi / 5) / widget.maxValue * widget.initialValue)) +
        150 -
        5;
    final y = (150 *
            sin(pi / 2 +
                pi / 10 +
                (2 * pi - pi / 5) / widget.maxValue * widget.initialValue)) +
        150 -
        5;
    return {'x': x, 'y': y};
  }

  double calculateMagnitude() {
    return calculateMagnitudeFromXY(_thumbx, _thumby);
  }

  double calculateMagnitudeFromXY(double x, double y) {
    final atanResult = atan2(y - 145, x - 145) - 3 * pi / 5;
    final atanFrom0to2pi =
        (atanResult <= 0) ? (2 * pi + atanResult) : atanResult;
    return (5 * widget.maxValue * (atanFrom0to2pi) / (9 * pi));
  }

  void updateXYAndSetValue(double x, double y, double width) {
    final xy = compensatedXY(x, y, width);

    if (xy != null) {
      final _value = calculateMagnitudeFromXY(xy['x'], xy['y']);
      if (_value < widget.maxValue + 1) {
        setState(() {
          value = _value;
          _thumbx = xy['x'];
          _thumby = xy['y'];
        });
      }
    }
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
              final x = details.localPosition.dx;
              final y = details.localPosition.dy;
              updateXYAndSetValue(x, y, width);
            },
            onPanEnd: (DragEndDetails details) {
              final _value = calculateMagnitude();
              setState(() {
                value = _value;
              });
              widget.onFinalSetPoint(value);
            },
            onPanUpdate: (DragUpdateDetails details) {
              final x = details.localPosition.dx;
              final y = details.localPosition.dy;
              updateXYAndSetValue(x, y, width);
            },
            onTapUp: (TapUpDetails details) {
              final _value = calculateMagnitude();
              setState(() {
                value = _value;
              });
              widget.onFinalSetPoint(value);
            },
            child: CustomPaint(
              painter:
                  OpenPainter(widget.color, width, height, _thumbx, _thumby),
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height,
                  child: Center(child: widget.centerWidget),
                ),
                Container(
                  child: Center(child: Text(value.toInt().toString())),
                )
              ],
            )),
      ],
    );
  }

  Map compensatedXY(double dx, double dy, double width) {
    if (dx > 0 && dy > 0 && dx < width && dy < width) {
      final angle = atan2(dy - width / 2, dx - width / 2);
      final x = width / 2 * cos(angle) - 5 + width / 2;
      final y = width / 2 * sin(angle) - 5 + width / 2;

      return {'x': x, 'y': y};
    }
    return null;
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
      ..strokeCap = StrokeCap.round
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
