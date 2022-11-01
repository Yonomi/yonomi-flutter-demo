import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yonomi_flutter_demo/assets/config_reader.dart';
import 'package:yonomi_flutter_demo/components/login_screen.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

import 'login_screen_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

var mockAppAuth = MockFlutterAppAuth();
var mockSecureStorage = MockFlutterSecureStorage();

Widget createLoginScreenWidget(BuildContext context) {
  return MaterialApp(
    theme: AppThemes.getMainTheme(context),
    initialRoute: 'login',
    routes: {
      'login': (context) => LoginScreen(
            {
              Config.CLIENT_ID: 'CLIENT_ID',
              Config.OAUTH_CALLBACK_URL: 'OAUTH_CALLBACK_URL',
              Config.AUDIENCE: 'AUDIENCE',
              'issuer': 'issuer',
              'scopes': [],
            },
            mockAppAuth,
            mockSecureStorage,
            enableLogging: false,
          ),
      'app': (context) {
        final String accessToken =
            ModalRoute.of(context)!.settings.arguments as String;
        return Text(accessToken);
      }
    },
  );
}

@GenerateMocks([FlutterAppAuth, FlutterSecureStorage])
void main() {
  testWidgets('should pass token value to next screen',
      (WidgetTester tester) async {
    final String token = 'testIdToken';
    when(mockAppAuth.authorizeAndExchangeCode(any))
        .thenAnswer((_) async => AuthorizationTokenResponse(
              token,
              "stubRefreshToken",
              DateTime.now(),
              "stubIdToken",
              "stubTokenType",
              [],
              {},
              {},
            ));

    await tester.pumpWidget(createLoginScreenWidget(MockBuildContext()));

    expect(find.text("Logging you in..."), findsWidgets);

    await tester.pumpAndSettle();

    expect(find.text(token), findsOneWidget);
  });

  testWidgets('should show Login button if initial Login failed',
      (WidgetTester tester) async {
    final String token = 'testIdToken';
    when(mockAppAuth.authorizeAndExchangeCode(any))
        .thenAnswer((_) async => throw Exception("Login failed"));

    await tester.pumpWidget(createLoginScreenWidget(MockBuildContext()));

    expect(find.text("Logging you in..."), findsWidgets);

    await tester.pumpAndSettle();

    expect(find.text('Press to Login'), findsOneWidget);
  });
}
