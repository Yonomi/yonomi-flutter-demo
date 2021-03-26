import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/widgets/components/device_control.dart';

Widget createDeviceControlWidget(bool initialValue) {
  return MaterialApp(
    home: Scaffold(
      body: DeviceControl(
        onOff: initialValue,
      ),
    ),
  );
}

void main() {
  testWidgets('Switch should exist', (WidgetTester tester) async {
    await tester.pumpWidget(createDeviceControlWidget(false));

    expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Switch,
          description: 'switch widget',
        ),
        findsOneWidget);
  });

  testWidgets('On should be rendered if it is On', (WidgetTester tester) async {
    await tester.pumpWidget(createDeviceControlWidget(true));

    expect(find.widgetWithText(DeviceControl, 'On'), findsOneWidget);
  });

  testWidgets('Off should be rendered if it is off',
      (WidgetTester tester) async {
    await tester.pumpWidget(createDeviceControlWidget(false));

    expect(find.widgetWithText(DeviceControl, 'Off'), findsOneWidget);
  });
}
