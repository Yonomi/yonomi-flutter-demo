import 'package:yonomi_platform_sdk/repository/artemis_client.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class LoginProvider {
  final String _userId;
  final Request _request;
  static Request _createRequest(
      String url, String privateKey, String tenantId, userId) {
    final token =
        ArtemisClientCreator.createToken(userId, tenantId, privateKey);
    print(token);
    return Request(url, {'Authorization': 'Bearer $token'});
  }

  LoginProvider(String userId, String url, String privateKey, String tenantId)
      : _userId = userId,
        _request = _createRequest(url, privateKey, tenantId, userId);

  String get userId => _userId;
  Request get request => _request;
}
