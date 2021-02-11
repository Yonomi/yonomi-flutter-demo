import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_platform_sdk/request/request.dart';
import 'package:yonomi_platform_sdk/user.dart';

class UserInfoProvider extends ChangeNotifier {
  String token =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTI5NTc1MzYsImV4cCI6MTYxMzA0MzkzNn0.lPrkNHutuISp01vujaRHFGFXlyYIcCLYhRhIOhLjMUssn95rb6KMP4Jd-Y3u1yloxkZkFRapnofAVp6HSdGodwqLDBbeoklEc-PMaNiU7auV2OmIzC825kt8HT_8_SU7ErGT4zSRPdJ8i927xl7lQuXi4FpzoDKKwmLr8dJe5joIu0qg2qKshknnUI7qgZ6IZdofFeX3I-MBkxoabbexqhF_OS-oT2wHJqOYK-7sTZ3iW2g165_ol9ud4j-uUCdbii4SvA3zpgB50YrafRYbZjktC9g5d09XBQs0YjmllZfGF1RbImZVzTWSFMDx7-RmNq61h3TYyHQrEFBcXR1-0Q';

  Future<UserModel> getUserDetails() async {
    Request request = Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql',
        {'Authorization': 'Bearer $token'});
    User user = await User.find().get(request);
    return UserModel(user.id, user.firstActivityAt, user.lastActivityAt);
  }
}
