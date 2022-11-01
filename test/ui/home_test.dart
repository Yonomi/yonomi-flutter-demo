import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/components/home.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/login_provider.dart';
import 'package:yonomi_flutter_demo/themes/string_constants.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

import 'home_test.mocks.dart';

DevicesProvider mockDevicesProvider = MockDevicesProvider();

final mockObserver = MockNavigatorObserver();

Widget createHomeWidget() {
  MockLoginProvider mockLoginProvider = MockLoginProvider();
  when(mockLoginProvider.request).thenReturn(Request("", {}));

  return MultiProvider(
    providers: [
      Provider<LoginProvider>(create: (context) => mockLoginProvider),
      ChangeNotifierProvider<DevicesProvider>.value(
        value: mockDevicesProvider,
      )
    ],
    child: MaterialApp(
      home: Column(children: [HomeWidget()]),
      navigatorObservers: [mockObserver],
      routes: {
        'lockDetailPage': (context) => Scaffold(
            extendBodyBehindAppBar: false,
            appBar: YonomiAppBar(
              StringConstants.default_app_bar_title,
              onPressed: () {},
            ),
            body: Text('Lock Detail Page'))
      },
    ),
  );
}

@GenerateMocks([DevicesProvider, LoginProvider],
    customMocks: [MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)])
void main() {
  final LockTrait lockedTrait =
      LockTrait({IsLocked(true)}, {SupportsIsJammed(false)});
  testWidgets('deviceItem should be rendered', (WidgetTester tester) async {
    when(mockDevicesProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockedTrait], 'lock description')
    ]);
    await tester.pumpWidget(createHomeWidget());

    expect(
        find.widgetWithText(DeviceItemWidget, 'Test Device'), findsOneWidget);
  });

  testWidgets('deviceItem should call provider action when tapped',
      (WidgetTester tester) async {
    when(mockDevicesProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockedTrait], 'lock description')
    ]);
    await tester.pumpWidget(createHomeWidget());
    await tester.tap(find.widgetWithText(DeviceItemWidget, 'Test Device'));
    verify(mockDevicesProvider.performAction(lockedTrait, 'id'));
  });

  testWidgets('device item widget (lock) - normal press should perform action',
      (WidgetTester tester) async {
    when(mockDevicesProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockedTrait], 'lock device')
    ]);
    await tester.pumpWidget(createHomeWidget());

    await tester.tap(find.widgetWithText(DeviceItemWidget, 'Test Device'));

    expect(
        find.widgetWithText(DeviceItemWidget, 'Test Device'), findsOneWidget);

    verify(mockDevicesProvider.performAction(lockedTrait, "id")).called(1);
  });

  testWidgets('device item widget (lock) - long press should show screen',
      (WidgetTester tester) async {
    when(mockDevicesProvider.devices).thenReturn([
      DeviceModel('id', 'Test Device', [lockedTrait], 'lock device')
    ]);
    await tester.pumpWidget(createHomeWidget());

    await tester
        .longPress(find.widgetWithText(DeviceItemWidget, 'Test Device'));
    verify(mockObserver.didPush(captureAny, captureAny));
    verifyNever(mockDevicesProvider.performAction(lockedTrait, "id"));
  });
}
