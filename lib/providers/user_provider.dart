import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/user_model.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

typedef GetIntegrationFunction = Future<List<dynamic>> Function(
    Request request);

typedef GetAccountUrlFunction = Future<String> Function(
    String integrationid, Request request);

typedef GetUserDetailsFunction = Future<User> Function(Request request);

class UserInfoProvider extends ChangeNotifier {
  UserModel? _userModel;
  bool loading = false;
  final Request request;

  UserInfoProvider(this.request);

  Future<void> fetchUserDetails(
      {GetUserDetailsFunction? getUserDetailsInjected}) async {
    loading = true;
    final getUserDetails =
        getUserDetailsInjected ?? UserRepository.getUserDetails;
    final userFromGraph = await getUserDetails(request);
    _userModel = UserModel(userFromGraph.id, userFromGraph.firstActivityAt,
        userFromGraph.lastActivityAt);

    loading = false;

    notifyListeners();
  }

  Future<List<Integration>> fetchIntegrations(
      {GetIntegrationFunction? getIntegrationInjected}) async {
    final getAllIntegration =
        getIntegrationInjected ?? AccountRepository.getAllIntegrations;
    final integrations = (await getAllIntegration(request))
        .map((integration) =>
            Integration(integration?.id, integration?.displayName))
        .toList();
    return integrations;
  }

  Future<String> fetchUrl(String integrationId,
      {GetAccountUrlFunction? getAccountUrlInjected}) async {
    final getAccountUrl =
        getAccountUrlInjected ?? AccountRepository.generateAccountUrl;
    return getAccountUrl(integrationId, request);
  }

  UserModel? get user => _userModel;
}

class Integration {
  final String? id;
  final String? displayName;

  Integration(this.id, this.displayName);
}
