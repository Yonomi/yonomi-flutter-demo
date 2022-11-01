import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class LoginProvider {
  final String _accessToken;
  final Request _request;

  LoginProvider(String accessToken, String url)
      : _accessToken = accessToken,
        _request = Request(url, {'Authorization': 'Bearer $accessToken'});

  String get accessToken => _accessToken;
  Request get request => _request;
}
