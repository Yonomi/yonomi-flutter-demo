import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:yonomi_flutter_demo/components/home.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/login_provider.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';

class MockDevicesProvider extends Mock implements DevicesProvider {}

class MockLoginProvider extends Mock implements LoginProvider {}

DevicesProvider mockProvider = MockDevicesProvider();

Widget createHomeWidget() {
  return MultiProvider(
    providers: [
      Provider<LoginProvider>(create: (context) => MockLoginProvider()),
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
    Trait lockTrait = LockUnlockTrait('lockUnlock', IsLocked(true));
    when(mockProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockTrait], 'description')
    ]);
    await tester.pumpWidget(createHomeWidget());

    expect(
        find.widgetWithText(DeviceItemWidget, 'Test Device'), findsOneWidget);
  });

  testWidgets('deviceItem should call provider action when tapped',
      (WidgetTester tester) async {
    Trait lockTrait = LockUnlockTrait('lockUnlock', IsLocked(true));
    when(mockProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockTrait], 'description')
    ]);
    await tester.pumpWidget(createHomeWidget());
    await tester.tap(find.widgetWithText(DeviceItemWidget, 'Test Device'));
    verify(mockProvider.performAction(lockTrait, 'id'));
  });
}
