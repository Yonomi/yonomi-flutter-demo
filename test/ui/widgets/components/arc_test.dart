import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/widgets/components/arc.dart';

Widget createArcWidget() {
  return MaterialApp(
    home: Column(children: [
      Arc(
          centerWidget: Text('centerWidget'),
          initialValue: 5,
          onFinalSetPoint: (double value) => print(value),
          maxValue: 100)
    ]),
  );
}

void main() {
  testWidgets('Center widget should be rendered', (WidgetTester tester) async {
    await tester.pumpWidget(createArcWidget());

    expect(find.widgetWithText(Arc, 'centerWidget'), findsOneWidget);
  });
}
