import 'package:flutter/material.dart';

/// A border that fits a ring-circle within the available space.
///
/// Typically used with [ShapeDecoration] to draw a circle.
///
/// The [dimensions] assume that the border is being used in a square space.
/// When applied to a rectangular space, the border paints in the center of the
/// rectangle.
///
/// See also:
///
///  * [CircleBorder], which is the parent implementation for this class.
///  * [Border], which, when used with [BoxDecoration], can also
///    describe a circle.
class RingBorder extends CircleBorder {
  const RingBorder({BorderSide side = BorderSide.none})
      : assert(side != null),
        super(side: side);

  @override
  RingBorder copyWith({BorderSide side}) {
    return RingBorder(side: side ?? this.side);
  }

  @override
  ShapeBorder scale(double t) => RingBorder(side: side.scale(t));

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        canvas.drawCircle(
            rect.center,
            (rect.shortestSide - side.width) / 2.0 + 2.0 * side.width,
            side.toPaint());
    }
  }
}
