import 'dart:math';

import 'package:flutter/widgets.dart';

import 'base_arc_painter.dart';

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
  final Color baseArcColor;

  final double strokeWidth;

  final double minimumRange, maximumRange, initialValue;

  final Color selectedArcColor;

  const SliderComponent(
      {Key key,
      @required this.mode,
      @required this.width,
      @required this.height,
      this.minimumRange,
      this.maximumRange,
      this.initialValue,
      this.baseArcColor,
      this.selectedArcColor,
      this.strokeWidth = DEFAULT_STROKE_WIDTH,
      this.centerWidget})
      : assert(maximumRange > minimumRange),
        assert(initialValue >= minimumRange && initialValue <= maximumRange),
        super(key: key);

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
            painter: BaseArcPainter(
                arcColor: widget.baseArcColor, strokeWidth: widget.strokeWidth),
            foregroundPainter: SelectorArcPainter(
                mode: widget.mode,
                arcColor: widget.baseArcColor,
                strokeWidth: widget.strokeWidth),
            child: widget.centerWidget,
          )),
    );
  }

  _handleTap() {}

  _handleDrag() {}
}

class SelectorArcPainter extends CustomPainter {
  SliderMode mode;

  Paint arcPainter;

  double startAngle;

  double endAngle;

  double sweepAngle;

  Color arcColor;

  double strokeWidth;

  SelectorArcPainter({
    @required this.mode,
    @required this.startAngle,
    @required this.endAngle,
    @required this.sweepAngle,
    @required this.arcColor,
    @required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    arcPainter = _getPaint(arcColor, PaintingStyle.stroke);
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius =
        min(size.width / 2, size.height / 2) - arcPainter.strokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi / 2 + startAngle, sweepAngle, false, arcPainter);
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
