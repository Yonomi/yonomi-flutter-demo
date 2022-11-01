import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsLoggerWrapper {
  static CrashlyticsLoggerWrapper? _instance;

  static get instance {
    _instance ??= CrashlyticsLoggerWrapper._();
    return _instance!;
  }

  CrashlyticsLoggerWrapper._();

  Future<void> logException(Object exception, StackTrace stacktrace,
      {required String reason}) async {
    await FirebaseCrashlytics.instance.recordError(exception, stacktrace,
        reason: 'An error occurred during login');
  }
}
