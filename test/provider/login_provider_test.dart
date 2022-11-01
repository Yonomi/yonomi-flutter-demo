import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/providers/login_provider.dart';

void main() {
  test('LoginProvider builds request object correctly', () {
    final String testAccessToken = 'testAccessToken';
    final loginProvider = LoginProvider(testAccessToken, 'url');

    expect(loginProvider.accessToken, equals(testAccessToken));
    expect(loginProvider.request.graphUrl, equals('url'));
    expect(loginProvider.request.headers['Authorization'], isNotNull);
    expect(loginProvider.request.headers['Authorization'],
        equals("Bearer ${testAccessToken}"));
  });
}
