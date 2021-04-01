import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class ProfileWidget extends StatefulWidget {
  static String title = "Home";

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  UserInfoProvider userInfoProvider;

  @override
  void initState() {
    super.initState();
    userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    userInfoProvider.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: 25),
        Consumer<UserInfoProvider>(builder: (context, userInfoProvider, child) {
          return userInfoProvider.loading
              ? Center(child: CircularProgressIndicator())
              : buildUserCard();
        }),
      ],
    );
  }

  Widget buildUserCard() {
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
          Text(userInfoProvider?.user?.displayName ?? ''),
          Text(userInfoProvider?.user?.firstActivityAt?.toString() ?? ''),
          Text(userInfoProvider?.user?.lastActivityAt?.toString() ?? ''),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
