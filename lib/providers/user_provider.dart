import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/repository/account_repository.dart';
import 'package:yonomi_platform_sdk/repository/user_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class UserInfoProvider extends ChangeNotifier {
  UserModel _userModel;
  bool loading = false;
  String _userId;
  Request _request;

  UserInfoProvider(String userId) {
    _userId = userId;
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

  Future<String> fetchUrl(String integrationId) async {
    if (_request == null) {
      _request = await YoRequest.request(_userId);
    }
    return AccountRepository.generateAccountUrl(integrationId, _request);
  }

  UserModel get user => _userModel;
}
