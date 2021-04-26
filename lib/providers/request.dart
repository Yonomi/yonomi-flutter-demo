import 'package:flutter/services.dart' show rootBundle;
import "package:yaml/yaml.dart";
import 'package:yonomi_platform_sdk/repository/artemis_client.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequest {
  String _token;
  String _url;

  static YoRequest _request;

  factory YoRequest(String userId, String configFileString, String privateKey) {
    _request =
        _request ?? YoRequest._internal(userId, configFileString, privateKey);
    return _request;
  }

  YoRequest._internal(
      String userId, String configFileString, String privateKey) {
    // Read yaml to get url, tenantId, secret
    Map config = loadYaml(configFileString);
    String tenantId = config['tenantId'];
    _url = config['url'];
    _token = ArtemisClientCreator.createToken(userId, tenantId, privateKey);
  }

  String get token => _token;
  String get url => _url;

  static Future<Request> request(String userId) async {
    String configFileString = await rootBundle.loadString('assets/config.yaml');
    String privateKey = await rootBundle.loadString('assets/jwtRS256.key');
    final yoRequest = YoRequest(userId, configFileString, privateKey);
    return Request(
        yoRequest.url, {'Authorization': 'Bearer ${yoRequest.token}'});
  }
}
