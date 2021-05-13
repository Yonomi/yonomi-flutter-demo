import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/assets/traits/name_icon_mapper.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';

Widget createIconWidget(List<Trait> traits) {
  return MaterialApp(
    home: Scaffold(
      body: Container(child: DeviceItemIcon.getIcon(traits)),
    ),
  );
}

void main() {
  testWidgets('should render correct thermostat trait icon',
      (WidgetTester tester) async {
    final thermostatDevice = [
      ThermostatTrait('thermostat', TargetTemperature(22))
    ];
    await tester.pumpWidget(createIconWidget(thermostatDevice));
    expect(find.widgetWithText(Center, '22'), findsOneWidget);
  });

  testWidgets('should render n/a if target temperature is null',
      (WidgetTester tester) async {
    final thermostatDevice = [
      ThermostatTrait('thermostat', TargetTemperature(null))
    ];
    await tester.pumpWidget(createIconWidget(thermostatDevice));
    expect(find.widgetWithText(Center, 'N/A'), findsOneWidget);
  });
}
