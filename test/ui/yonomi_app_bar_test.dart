import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';

Widget createYonomiAppBarWidget(
    {String titleString, bool notified, Function onPressed}) {
  return MaterialApp(
      home: Scaffold(
    body: Text("Test"),
    bottomNavigationBar: YonomiAppBar(
      titleString,
      notification: notified,
      onPressed: onPressed,
    ),
  ));
}

void main() {
  testWidgets('Should find App Bar with given text',
      (WidgetTester tester) async {
    await tester.pumpWidget(createYonomiAppBarWidget(
        titleString: "My App Bar", notified: false, onPressed: () {}));

    expect(find.text("My App Bar"), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsNothing);
  });

  testWidgets('Should find App Bar with notification badge',
      (WidgetTester tester) async {
    await tester.pumpWidget(createYonomiAppBarWidget(
        titleString: "My App Bar with badge",
        notified: true,
        onPressed: () {}));

    expect(find.text("My App Bar with badge"), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsOneWidget);
  });

  testWidgets('Should handle onPress for App Bar button',
      (WidgetTester tester) async {
    bool wasButtonPressed = false;

    await tester.pumpWidget(createYonomiAppBarWidget(
        titleString: "My App Bar onPressed",
        notified: false,
        onPressed: () {
          wasButtonPressed = true;
        }));

    expect(find.text("My App Bar onPressed"), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsNothing);

    Finder button = find.byIcon(Icons.notifications);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(wasButtonPressed, true);
  });
}
