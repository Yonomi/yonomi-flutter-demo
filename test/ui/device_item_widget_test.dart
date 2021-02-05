import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/models/device_item_model.dart';

Widget createDeviceItemWidget(
        {String testLocation, String testName, String testState}) =>
    ChangeNotifierProvider<DeviceItemModel>(
      create: (context) {
        return DeviceItemModel(
            location: testLocation, name: testName, state: testState);
      },
      child: MaterialApp(
        home: DeviceItemWidget(),
      ),
    );

// );
void main() {
  group("DeviceItemWidget", () {
    testWidgets('empty location - shows default text',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createDeviceItemWidget(testName: "N", testState: "S"));

      expect(find.text("No location set"), findsOneWidget);
    });

    testWidgets('empty name - shows default text', (WidgetTester tester) async {
      await tester.pumpWidget(
          createDeviceItemWidget(testLocation: "L", testState: "S"));

      expect(find.text("No name"), findsOneWidget);
    });

    testWidgets('empty State - shows default text',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createDeviceItemWidget(testLocation: "L", testName: "N"));

      expect(find.text("Unknown"), findsOneWidget);
    });

    testWidgets('shows Location name', (WidgetTester tester) async {
      await tester.pumpWidget(createDeviceItemWidget(
          testLocation: "My Location", testName: "", testState: ""));

      expect(find.text("My Location"), findsOneWidget);
    });

    testWidgets('shows Name', (WidgetTester tester) async {
      await tester.pumpWidget(createDeviceItemWidget(
          testLocation: "", testName: "Device Name", testState: ""));

      expect(find.text("Device Name"), findsOneWidget);
    });

    testWidgets('shows State', (WidgetTester tester) async {
      await tester.pumpWidget(createDeviceItemWidget(
          testLocation: "", testName: "", testState: "Off"));

      expect(find.text("Off"), findsOneWidget);
    });
  });
}
