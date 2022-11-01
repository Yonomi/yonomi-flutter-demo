import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';

Widget createDeviceItemWidget(
    {String? state,
    String? name,
    String? location,
    IconData? iconData,
    VoidCallback? onPressed}) {
  return MaterialApp(
    home: DeviceItemWidget(
      deviceIcon: Icon(iconData),
      state: state,
      name: name,
      location: location,
      onPressed: onPressed,
    ),
  );
}

Widget createLargeDeviceItemWidget(double scaleFactor,
    {String? state,
    String? name,
    String? location,
    IconData? iconData,
    VoidCallback? onPressed}) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(textScaleFactor: scaleFactor),
      child: DeviceItemWidget(
        deviceIcon: Icon(iconData),
        state: state,
        name: name,
        location: location,
        onPressed: onPressed,
      ),
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

      await tester.tap(find.widgetWithText(DeviceItemWidget, "testWidget"));

      expect(log.length, 1);
    });

    testWidgets(
        'long, overflowing text does not stretch height of DeviceItemWidget',
        (WidgetTester tester) async {
      var itemUnderTest = createLargeDeviceItemWidget(3.5,
          iconData: Icons.home,
          location:
              "A super long text that overflows the container A super long text that overflows the container",
          name:
              "A super long text that overflows the container A super long text that overflows the container",
          state: "Off");

      await tester.pumpWidget(itemUnderTest);
      await tester.pumpAndSettle();

      var deviceItemWidget = tester.firstWidget(find.byType(DeviceItemWidget));
      expect(deviceItemWidget, isNotNull);

      final Size widgetSize = tester.getSize(find.byType(DeviceItemWidget));
      expect(widgetSize.height, equals(600.0));
    });
  });
}
