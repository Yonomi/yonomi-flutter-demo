import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/components/login_screen.dart';

Widget createLoginScreenWidget() {
  return MaterialApp(home: LoginScreen());
}

void main() {
  testWidgets('Should find correct text in login screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreenWidget());

    expect(find.text("Please Enter User Id"), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
  });
}
