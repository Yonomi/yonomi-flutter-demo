import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:yonomi_flutter_demo/components/home.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_platform_sdk/traits/trait.dart';

class MockDevicesProvider extends Mock implements DevicesProvider {}

DevicesProvider mockProvider = MockDevicesProvider();

Widget createHomeWidget() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<DevicesProvider>.value(
        value: mockProvider,
      )
    ],
    child: MaterialApp(
      home: Column(children: [HomeWidget()]),
    ),
  );
}

void main() {
  testWidgets('deviceItem should be rendered', (WidgetTester tester) async {
    Trait lockTrait = Trait('LOCK_UNLOCK', IsLocked(ReportedIsLocked(true)));
    when(mockProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockTrait])
    ]);
    await tester.pumpWidget(createHomeWidget());

    expect(
        find.widgetWithText(DeviceItemWidget, 'Test Device'), findsOneWidget);
  });

  testWidgets('deviceItem should call provider action when tapped',
      (WidgetTester tester) async {
    Trait lockTrait = Trait('LOCK_UNLOCK', IsLocked(ReportedIsLocked(true)));
    when(mockProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockTrait])
    ]);
    // when(mockProvider.)
    await tester.pumpWidget(createHomeWidget());
    await tester.tap(find.widgetWithText(DeviceItemWidget, 'Test Device'));
    verify(mockProvider.performAction(lockTrait, 'id'));
  });
}
