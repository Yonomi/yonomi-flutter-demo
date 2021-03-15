import 'dart:math';

import 'package:flutter/widgets.dart';

enum SliderMode { singleSelection, doubleSelection }

class SliderComponent extends StatefulWidget {
  final SliderMode mode;
  final int width, height;
  final Widget centerWidget;
  final Color arcColor;

  const SliderComponent(
      {Key key,
      @required this.mode,
      @required this.width,
      @required this.height,
      this.arcColor,
      this.centerWidget})
      : super(key: key);

  @override
  _SliderComponent createState() => _SliderComponent();
}

class _SliderComponent extends State<SliderComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SliderComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width.toDouble(),
      height: widget.height.toDouble(),
      child: GestureDetector(
          onTapDown: _handleTap(),
          onPanUpdate: _handleDrag(),
          child: CustomPaint(
            painter:
                CircularPainter(mode: widget.mode, arcColor: widget.arcColor),
            child: widget.centerWidget,
          )),
    );
  }

  _handleTap() {}

  _handleDrag() {}
}

class CircularPainter extends CustomPainter {
  SliderMode mode;

  Color arcColor;

  double sliderStrokeWidth;

  Offset center;

  double radius;

  double startAngle = 0;
  double sweepAngle = 0;

  CircularPainter({@required this.mode, @required this.arcColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = _getPaint(arcColor, PaintingStyle.stroke);

    sliderStrokeWidth = 4;
    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2) - sliderStrokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi / 2 + startAngle, sweepAngle, false, painter);
  }

  Paint _getPaint(@required color, PaintingStyle style) => Paint()
    ..color = color
    ..style = style ?? PaintingStyle.stroke;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
