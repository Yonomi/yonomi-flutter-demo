import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/login_screen.dart';

Widget createLoginScreenWidget() {
  return MaterialApp(
    home: LoginScreen(),
    initialRoute: 'login',
    routes: {
      'login': (context) => LoginScreen(),
      'app': (context) => Text('Next Page')
    },
  );
}

void main() {
  testWidgets('Should find correct text in login screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreenWidget());

    expect(find.text("Please Enter User Id"), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
  });

  testWidgets('should not navigate if string is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreenWidget());

    expect(find.byType(FloatingActionButton), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Next Page'), findsNothing);
  });

  testWidgets('should navigate if string is not empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreenWidget());

    expect(find.byType(FloatingActionButton), findsOneWidget);
    await tester.enterText(find.byType(TextField), '1234');

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Next Page'), findsOneWidget);
  });
}
