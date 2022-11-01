import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yonomi_flutter_demo/assets/config_reader.dart';
import 'package:yonomi_flutter_demo/utils/loggers/crashlytics_logger_wrapper.dart';

class LoginScreen extends StatefulWidget {
  final Map configData;
  final FlutterAppAuth appAuth;
  final FlutterSecureStorage secureStorage;

  CrashlyticsLoggerWrapper? logger = CrashlyticsLoggerWrapper.instance;

  LoginScreen(this.configData, this.appAuth, this.secureStorage,
      {bool enableLogging = true}) {
    this.logger = (!enableLogging) ? null : logger;
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    initiateLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoggingIn ? Text('Logging you in...') : Text(''),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoggingIn
              ? Column(
                  children: [
                    Text('Logging you in...'),
                    SizedBox(
                      height: 16.0,
                    ),
                    CircularProgressIndicator(),
                  ],
                )
              : ElevatedButton(
                  child: Text('Press to Login'),
                  onPressed: () => initiateLogin(),
                ),
        ),
      ),
    );
  }

  Future<void> initiateLogin() async {
    setState(() => isLoggingIn = true);

    Map config = widget.configData;
    final appAuth = widget.appAuth;
    final FlutterSecureStorage secureStorage = widget.secureStorage;

    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          config[Config.CLIENT_ID],
          config[Config.OAUTH_CALLBACK_URL],
          additionalParameters: {'audience': config[Config.AUDIENCE]},
          issuer: 'https://${config[Config.DOMAIN]}',
          scopes: ['openid', 'profile', 'offline_access'],
        ),
      );

      final String? accessToken = result!.accessToken;
      await secureStorage.write(key: 'access_token', value: accessToken);

      openApp(accessToken!);
    } catch (exception, stacktrace) {
      await widget.logger?.logException(exception, stacktrace,
          reason: 'An error occurred during login');
      setState(() => isLoggingIn = false);
      showToast(context, "An error occurred trying to log in.");
    }
  }

  void showToast(BuildContext context, String message) {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            ));
  }

  void openApp(String accessToken) {
    Navigator.pushNamed(
      context,
      'app',
      arguments: accessToken,
    );
  }
}
