import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/integration_list.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';

Future<List<Integration>> createCorrectIntegrationList() async {
  return [
    Integration('id1', 'displayName1'),
    Integration('id2', 'displayName2')
  ];
}

Future<List<Integration>> createEmptyList() async {
  return [];
}

Future<List<Integration>> createErrorSituation() async {
  return Future.error('something bad happened');
}

Widget createIntegrationListWidget(
    Future<List<Integration>> integrations, ValueChanged<String> onPress) {
  return MaterialApp(
    home: Scaffold(
      body: IntegrationList(
        integrations: integrations,
        onPress: onPress,
      ),
    ),
  );
}

void onPressMock(String id) {}

void main() {
  testWidgets('should render chips if integration list is passed',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(createIntegrationListWidget(
          createCorrectIntegrationList(), (id) => 0));
      await tester.pumpAndSettle();
      expect(
          find.widgetWithText(IntegrationList, 'displayName1'), findsOneWidget);
      expect(
          find.widgetWithText(IntegrationList, 'displayName2'), findsOneWidget);
    });
  });

  testWidgets('should render error if error is thrown',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
          createIntegrationListWidget(createErrorSituation(), (id) => 0));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(IntegrationList, "Couldn't load integrations"),
          findsOneWidget);
    });
  });

  testWidgets('should render no integration found if integration is empty',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
          createIntegrationListWidget(createEmptyList(), (id) => 0));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(IntegrationList, 'No Integration Found'),
          findsOneWidget);
    });
  });

  // testWidgets('passed method should be pressed on tap',
  //     (WidgetTester tester) async {
  //   await tester.runAsync(() async {
  //     when(onPressMock('id1')).thenReturn(null);
  //     await tester.pumpWidget(createIntegrationListWidget(
  //         createCorrectIntegrationList(), onPressMock));
  //     await tester.pumpAndSettle();
  //     await tester.tap(find.widgetWithText(Text, 'displayName1'));
  //     verify(onPressMock('id1')).called(1);
  //   });
  // });
  // testWidgets('Off should be rendered if it is off',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(createIntegrationListWidget(false));

  //   expect(find.widgetWithText(DeviceControl, 'Off'), findsOneWidget);
  // });
}
