import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/yonomi_bottom_app_bar.dart';

Widget createYonomiBottomAppBarWidget(
    {int? selectedIndex, ValueChanged<int>? onPressed}) {
  return MaterialApp(
      home: Scaffold(
    body: Text("Test"),
    bottomNavigationBar: YonomiBottomAppBar(
      selectedIndex: selectedIndex,
      onTap: onPressed,
    ),
  ));
}

void main() {
  testWidgets('Should select Home for index 0', (WidgetTester tester) async {
    await tester.pumpWidget(createYonomiBottomAppBarWidget(
        selectedIndex: 0, onPressed: (int i) {}));

    expect(
        find.byWidget(YonomiBottomAppBar.homeSelectedWidget), findsOneWidget);
    expect(find.byWidget(YonomiBottomAppBar.devicesUnselectedWidget),
        findsOneWidget);
    expect(find.byWidget(YonomiBottomAppBar.settingsUnselectedWidget),
        findsOneWidget);
  });

  testWidgets('Should select Devices for index 1', (WidgetTester tester) async {
    await tester.pumpWidget(createYonomiBottomAppBarWidget(
        selectedIndex: 1, onPressed: (int i) {}));

    expect(find.byWidget(YonomiBottomAppBar.devicesSelectedWidget),
        findsOneWidget);
    expect(
        find.byWidget(YonomiBottomAppBar.homeUnselectedWidget), findsOneWidget);
    expect(find.byWidget(YonomiBottomAppBar.settingsUnselectedWidget),
        findsOneWidget);
  });

  testWidgets('Should select Settings for index 2',
      (WidgetTester tester) async {
    await tester.pumpWidget(createYonomiBottomAppBarWidget(
        selectedIndex: 2, onPressed: (int i) {}));

    expect(find.byWidget(YonomiBottomAppBar.settingsSelectedWidget),
        findsOneWidget);
    expect(
        find.byWidget(YonomiBottomAppBar.homeUnselectedWidget), findsOneWidget);
    expect(find.byWidget(YonomiBottomAppBar.devicesUnselectedWidget),
        findsOneWidget);
  });
}
