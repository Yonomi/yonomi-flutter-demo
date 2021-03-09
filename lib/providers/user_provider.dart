import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/account.dart';
import 'package:yonomi_platform_sdk/repository/account_repository.dart';
import 'package:yonomi_platform_sdk/repository/user_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class UserInfoProvider extends ChangeNotifier {
  UserModel _userModel;

  UserInfoProvider() {
    fetchUserDetails();
  }

  Request request = YoRequestFactory.request();

  Future<void> fetchUserDetails() async {
    final userFromGraph = await UserRepository.getUserDetails(request);

    _userModel = UserModel(
        userFromGraph?.id ?? '',
        userFromGraph?.firstActivityAt ?? '',
        userFromGraph?.lastActivityAt ?? '');
    notifyListeners();
  }

  Future<String> fetchUrl(String integrationId) async {
    return AccountRepository.generateAccountUrl(integrationId, request);
  }

  UserModel get user => _userModel;
}
