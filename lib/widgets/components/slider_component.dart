import 'dart:math';

import 'package:flutter/widgets.dart';

enum SliderMode { singleSelection, doubleSelection }

const double DEFAULT_STROKE_WIDTH = 8;

class SliderComponent extends StatefulWidget {
  /// Creates a Slider component that represents a range of values in an
  /// arc-shaped slider that can be selected by the user.
  ///
  /// The [mode], [width] and [height] arguments must not be null.
  ///
  /// Optionally, you can pass a [centerWidget] that will be rendered
  /// in the middle of the slider component.
  ///

  final SliderMode mode;
  final int width, height;
  final Widget centerWidget;
  final Color arcColor;

  final double strokeWidth;

  const SliderComponent(
      {Key key,
      @required this.mode,
      @required this.width,
      @required this.height,
      this.arcColor,
      this.strokeWidth = DEFAULT_STROKE_WIDTH,
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
            painter: ArcPainter(
                mode: widget.mode,
                arcColor: widget.arcColor,
                strokeWidth: widget.strokeWidth),
            child: widget.centerWidget,
          )),
    );
  }

  _handleTap() {}

  _handleDrag() {}
}

class ArcPainter extends CustomPainter {
  SliderMode mode;

  Color arcColor;

  double sliderStrokeWidth;

  Offset center;

  double radius;

  double startAngle = 0;
  double sweepAngle = 0;

  double strokeWidth;

  ArcPainter(
      {@required this.mode,
      @required this.arcColor,
      @required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = _getPaint(arcColor, PaintingStyle.stroke);

    sliderStrokeWidth = this.strokeWidth;
    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2) - sliderStrokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        pi / 2 + pi / 10, 2 * pi - pi / 5, false, painter);
  }

  Paint _getPaint(@required color, PaintingStyle style) => Paint()
    ..color = color
    ..style = style ?? PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = this.strokeWidth;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
