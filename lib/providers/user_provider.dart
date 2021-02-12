import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_platform_sdk/request/request.dart';
import 'package:yonomi_platform_sdk/user.dart';

class UserInfoProvider extends ChangeNotifier {
  UserModel _userModel;

  UserInfoProvider() {
    fetchUserDetails();
  }
  String token =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTMxNjg1NTUsImV4cCI6MTYxMzI1NDk1NX0.hQo5iws5CPZkwzdKV3CaAzxmuwkD9buJ-uXjKyUl_soTqhNGTGtV_VDBMbDN7KF0YjH9N9XMh5IfI49tjvtFodOJCkKn08X__lw2nJmwKXKGkJ7TDRx0dTm01oTF75OJBohShciX6tP3ShRtFn3_xo1Hu4eakOuCgrlsfAG92klQo9KRs_3NdU5NWUsgoYWpPI_JySpT_bsAj97Thv91axIctsfZUoGiKivO_602v16d3T910vpf0S8o-FRcfxpBx4ag4dgnUOjH1QasFqDCq2C9MySOd5eaFJFQ67nq8CLWGpPS96Oz4aIiRi1xgJQlDrSQesmQ-htAk5s4sPsKdg';

  Future<void> fetchUserDetails() async {
    Request request = Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql',
        {'Authorization': 'Bearer $token'});
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

  UserModel get user => _userModel;
}
