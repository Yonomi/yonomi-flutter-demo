import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';

Widget createDeviceItemWidget(
    {String state,
    String name,
    String location,
    IconData iconData,
    VoidCallback onPressed}) {
  return MaterialApp(
    home: DeviceItemWidget(
      icon: iconData,
      state: state,
      name: name,
      location: location,
      onPressed: onPressed,
    ),
  );
}

void main() {
  group("DeviceItemWidget", () {
    testWidgets('empty location - shows default text on label',
        (WidgetTester tester) async {
      await tester.pumpWidget(createDeviceItemWidget(name: "N", state: "S"));

      expect(find.text("No location set"), findsOneWidget);
    });

    testWidgets('empty name - shows default text on label',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createDeviceItemWidget(location: "L", state: "S"));

      expect(find.text("No name"), findsOneWidget);
    });

    testWidgets('empty State - shows default text on label',
        (WidgetTester tester) async {
      await tester.pumpWidget(createDeviceItemWidget(location: "L", name: "N"));

      expect(find.text("Unknown"), findsOneWidget);
    });

    testWidgets('shows desired Location name on label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createDeviceItemWidget(location: "My Location", name: "", state: ""));

      expect(find.text("My Location"), findsOneWidget);
    });

    testWidgets('shows desired Device Name on label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createDeviceItemWidget(location: "", name: "Device Name", state: ""));

      expect(find.text("Device Name"), findsOneWidget);
    });

    testWidgets('shows desired State on label', (WidgetTester tester) async {
      await tester.pumpWidget(
          createDeviceItemWidget(location: "", name: "", state: "Off"));

      expect(find.text("Off"), findsOneWidget);
    });

    testWidgets('shows configured Icon ', (WidgetTester tester) async {
      await tester.pumpWidget(createDeviceItemWidget(
          iconData: Icons.home, location: "", name: "", state: "Off"));

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('onPressed is handled correctly ', (WidgetTester tester) async {
      final log = <int>[];
      final onPressed = () => log.add(0);

      await tester.pumpWidget(
          createDeviceItemWidget(name: "testWidget", onPressed: onPressed));

      await tester.tap(find.text("testWidget"));

      expect(log.length, 0);
    });
  });
}
