import 'package:flutter/widgets.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_platform_sdk/request/request.dart';
import 'package:test/test.dart';

Future<List<dynamic>> getEmptyIntegrations(Request request) async {
  return [];
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('should return correct integration list for correct list', () async {
    Future<List<dynamic>> getAllGoodIntegrations(Request request) async {
      return [
        Integration('id1', 'displayName1'),
        Integration('id2', 'displayName2'),
      ];
    }

    final userProvider =
        UserInfoProvider('userId', request: Request('url', null));
    final integrations = await userProvider.fetchIntegrations(
        getIntegration: getAllGoodIntegrations);
    expect(integrations.length, equals(2));
  });
}
