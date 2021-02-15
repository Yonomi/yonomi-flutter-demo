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
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTM0MTExMTYsImV4cCI6MTYxMzQ5NzUxNn0.1UzVcmXx_zghlJb_kMQehfyX_SiX9I5dP58QjeUQGBKQgVMAhew-Jfj_JHHv7HY32XtvNaSiLSkaN2iQ5fW5YM7799BhmOvxEzM13CU6hzcCk1j26l4pes_hTbYbr8l3VmKQ8VOeGuotBcqNAiEN9J88rjJTjbLXgdukQ9WGbnjP3NTtmY-nRwSuS71gDmW8q0pBBwxJbX9_Cc5i09tYnQrahtCumeH7DpU8xHEsmyYCUT9PqwhVU3vU12g67aPrMyCEy5c7HqqdYd5uOsf7O9Arbg90kCLuosjlV9mhkrj4YrixuD8-oNkpFtRbjzUXdMou-4DSc5xUc-V2xuAIZg';

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
