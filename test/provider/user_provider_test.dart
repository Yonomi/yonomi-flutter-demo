import 'package:flutter/widgets.dart';
import 'package:yonomi_flutter_demo/models/user_model.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_platform_sdk/repository/user_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';
import 'package:test/test.dart';

Future<List<dynamic>> getEmptyIntegrations(Request request) async {
  return [];
}

UserInfoProvider createMockProvider() => UserInfoProvider('userId',
    request: Future<Request>.value(Request('graphUrl', null)));

void main() {
  test('should return correct integration list for correct list', () async {
    Future<List<dynamic>> getAllGoodIntegrations(Request request) async {
      return [
        Integration('id1', 'displayName1'),
        Integration('id2', 'displayName2'),
      ];
    }

    final userProvider = createMockProvider();
    final integrations = await userProvider.fetchIntegrations(
        getIntegrationInjected: getAllGoodIntegrations);
    expect(integrations.length, equals(2));
  });

  test('should return correct url for given integration id', () async {
    final getAccountUrl =
        (String id, Request request) => Future<String>.value('url');
    final userProvider = createMockProvider();
    final accountUrl = await userProvider.fetchUrl('integrationId',
        getAccountUrlInjected: getAccountUrl);
    expect(accountUrl, equals('url'));
  });

  test('should return userdetails for details returned from repository',
      () async {
    final expectedId = 'expectedId';
    final expectedFirstActivityAt = DateTime(2021, 1, 1);
    final expectedLastActivityAt = DateTime(2021, 1, 2);
    final getUserDetails = (Request request) => Future<User>.value(User(
        expectedId,
        expectedFirstActivityAt,
        expectedLastActivityAt,
        Tenant('id', 'displayName')));
    final userProvider = createMockProvider();
    await userProvider.fetchUserDetails(getUserDetailsInjected: getUserDetails);

    expect(userProvider.user.id, expectedId);
    expect(userProvider.user.firstActivityAt, expectedFirstActivityAt);
    expect(userProvider.user.lastActivityAt, expectedLastActivityAt);
  });
}
