import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/providers/thermostat_provider.dart';
import 'package:yonomi_flutter_demo/widgets/components/slider_component.dart';

class MockThermostatProvider extends Mock implements ThermostatProvider {}

ThermostatProvider mockProvider = MockThermostatProvider();

Widget createSliderComponentWidget() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ThermostatProvider>.value(
        value: mockProvider,
      )
    ],
    child: MaterialApp(
      home: Column(children: [
        SliderComponent(
            mode: SliderMode.singleSelection, width: 200, height: 200)
      ]),
    ),
  );
}

void main() {
  testWidgets("basic SliderComponent test", (WidgetTester tester) async {
    Widget sliderComponentInTest = createSliderComponentWidget();
  });
}
