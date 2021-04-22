import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/user_model.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class SettingsWidget extends StatelessWidget {
  static final String title = "Settings";

  Widget build(BuildContext context) {
    List<UserModel> accounts = [
      UserModel('Some DisplayName', DateTime.now(), DateTime.now())
    ];
    if (accounts.isEmpty)
      return Center(
        child: Text('No Accounts'),
      );
    return ListView(
      children: accounts.map((e) {
        final innerText = (e.id);
        return Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppThemes.listViewBackgroundColor),
            child: Center(
              child: Column(
                children: [
                  Text(
                    innerText,
                    style: TextStyle(color: AppThemes.listViewTextColor),
                  )
                ],
              ),
            ));
      }).toList(),
      // children: [Text(edges[0]['node']['createdAt'].toString())],
      shrinkWrap: true,
    );
  }
}
