import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/repository/account_repository.dart';
import 'package:yonomi_platform_sdk/repository/user_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

typedef GetIntegrationFunction = Future<List<dynamic>> Function(
    Request request);

class UserInfoProvider extends ChangeNotifier {
  UserModel _userModel;
  bool loading = false;
  String _userId;
  Request _request;

  UserInfoProvider(String userId, {Request request}) {
    _userId = userId;
    _request = request;
  }

  Future<void> fetchUserDetails() async {
    loading = true;
    if (_request == null) {
      _request = await YoRequest.request(_userId);
    }
    final userFromGraph = await UserRepository.getUserDetails(_request);
    _userModel = UserModel(
        userFromGraph?.id ?? '',
        userFromGraph?.firstActivityAt ?? '',
        userFromGraph?.lastActivityAt ?? '');

    loading = false;

    notifyListeners();
  }

  Future<List<Integration>> fetchIntegrations(
      {GetIntegrationFunction getIntegration}) async {
    if (_request == null) {
      _request = await YoRequest.request(_userId);
    }
    GetIntegrationFunction getAllIntegration =
        getIntegration ?? AccountRepository.getAllIntegrations;
    final integrations = (await getAllIntegration(_request))
        .map((integration) =>
            Integration(integration?.id, integration?.displayName))
        .toList();
    return integrations;
  }

  Future<String> fetchUrl(String integrationId) async {
    if (_request == null) {
      _request = await YoRequest.request(_userId);
    }
    return AccountRepository.generateAccountUrl(integrationId, _request);
  }

  UserModel get user => _userModel;
}

class Integration {
  final String id;
  final String displayName;

  Integration(this.id, this.displayName);
}
