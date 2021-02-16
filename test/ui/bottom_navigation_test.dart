import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/accounts.dart';
import 'package:yonomi_flutter_demo/main.dart';

void main() {
  testWidgets('Tapping on Home Icon takes you to Home screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the 'Home' icon
    await tester.tap(find.text("Home"));
    await tester.pumpAndSettle();

    // Verify that we are in the 'Home' screen
    expect(find.text("Home"), findsNWidgets(2));
  });

  testWidgets('Tapping on Devices Icon takes you to Devices screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the 'Routines' icon
    await tester.tap(find.bySemanticsLabel("Routines"));
    await tester.pumpAndSettle();

    // Verify that we are in the 'Routines' screen
    expect(find.text("Devices"), findsOneWidget);
  });

  testWidgets('Tapping on Settings Icon takes you to Settings screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the 'Settings' icon
    await tester.tap(find.text("Settings"));
    await tester.pumpAndSettle();

    // Verify that we are in the 'Settings' screen
    expect(find.byType(SettingsWidget), findsOneWidget);
  });
}
