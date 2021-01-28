import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/main.dart';

void main() {
  testWidgets('Tapping on Home Icon takes you to Home screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the 'Home' icon
    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();

    // Verify that we are in the 'Home' screen
    expect(find.text("Home"), findsOneWidget);
  });

  testWidgets('Tapping on Routines Icon takes you to Routines screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the 'Routines' icon
    await tester.tap(find.byIcon(Icons.handyman));
    await tester.pump();

    // Verify that we are in the 'Routines' screen
    expect(find.text("Routines"), findsOneWidget);
  });

  testWidgets('Tapping on Settings Icon takes you to Settings screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the 'Settings' icon
    await tester.tap(find.byIcon(Icons.admin_panel_settings));
    await tester.pump();

    // Verify that we are in the 'Settings' screen
    expect(find.text("Settings"), findsOneWidget);
  });
}
