import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/accountModel.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

class AccountsWidget extends StatelessWidget {
  static String title = "Settings";

  Widget build(BuildContext context) {
    List<AccountModel> accounts = [AccountModel('Some DisplayName')];
    if (accounts.isEmpty)
      return Center(
        child: Text('No Accounts'),
      );
    return ListView(
      children: accounts.map((e) {
        final innerText = (e.displayName);
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
