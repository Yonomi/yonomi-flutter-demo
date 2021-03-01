import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/account.dart';
import 'package:yonomi_platform_sdk/request/request.dart';
import 'package:yonomi_platform_sdk/user.dart';

class UserInfoProvider extends ChangeNotifier {
  UserModel _userModel;

  UserInfoProvider() {
    fetchUserDetails();
  }

  Request request = YoRequestFactory.request();

  Future<void> fetchUserDetails() async {
    User userQuery = User.find()
      ..project([
        UserFields.firstActivityAt,
        UserFields.lastActivityAt,
        UserFields.id
      ]);

    User user = await userQuery.get(request);
    _userModel = UserModel(user?.id ?? '', user?.firstActivityAt ?? '',
        user?.lastActivityAt ?? '');
    notifyListeners();
  }

  Future<String> fetchUrl(String integrationId) async {
    return Account.generateAccountLinkingUrl(integrationId, request);
  }

  UserModel get user => _userModel;
}
