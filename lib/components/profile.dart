import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class ProfileWidget extends StatelessWidget {
  static String title = "Home";

  Widget build(BuildContext context) {
    final Widget user = getUserWidget();
    // userInfoProvider.fetchUserDetails();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[SizedBox(height: 25), user],
    );
  }

  Widget getUserWidget() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.yellow,
            title: Text("Profile",
                style: const TextStyle(
                  color: AppThemes.listViewTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                )),
          ),
          SizedBox(height: 20),
          Consumer<UserInfoProvider>(
            builder: (context, data, child) {
              return Text(data?.user?.displayName ?? '');
            },
          ),
          Consumer<UserInfoProvider>(
            builder: (context, data, child) {
              return Text(data?.user?.firstActivityAt?.toString() ?? '');
            },
          ),
          Consumer<UserInfoProvider>(
            builder: (context, data, child) {
              return Text(data?.user?.lastActivityAt?.toString() ?? '');
            },
          ),
          SizedBox(height: 20) // Text(result.data['me']['firstActivityAt']),
        ],
      ),
    );
  }
}
