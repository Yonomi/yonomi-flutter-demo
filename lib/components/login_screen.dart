import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';

import 'settings_dialog.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsDialog(
      title: "Login",
      accessToken: YoRequestCreator.token,
      defaultUrl: YoRequestCreator.endpoint,
    );
  }
}
