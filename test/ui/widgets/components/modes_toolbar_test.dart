import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/widgets/components/modes_toolbar.dart';

Widget createModesToolbar() {
  return MaterialApp(
    home: Column(children: [
      ModesToolbar(
        children: [
          ModeIconButton(
            icon: Text("A"),
            onPressed: () {},
          ),
          ModeIconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {},
          ),
          ModeIconButton(
            icon: Icon(Icons.whatshot),
            onPressed: () {},
          ),
          ModeIconButton(
            icon: Icon(Icons.eco),
            onPressed: () {},
          ),
        ],
      ),
    ]),
  );
}

void main() {
  testWidgets('Setup - ModesToolbar should contain specific icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(createModesToolbar());

    expect(find.widgetWithIcon(ModesToolbar, Icons.ac_unit), findsOneWidget);
    expect(find.widgetWithIcon(ModesToolbar, Icons.whatshot), findsOneWidget);
    expect(find.widgetWithIcon(ModesToolbar, Icons.eco), findsOneWidget);
  });

  testWidgets('', (WidgetTester tester) async {
    await tester.pumpWidget(createModesToolbar());
  });
}
