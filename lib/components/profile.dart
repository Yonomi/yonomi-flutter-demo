import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/models/user_model.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class ProfileWidget extends StatefulWidget {
  static String title = "Home";

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late UserInfoProvider userInfoProvider;

  @override
  void initState() {
    super.initState();
    userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    userInfoProvider.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          Consumer<UserInfoProvider>(
            builder: (context, userInfoProvider, cardTitleWidget) {
              return userInfoProvider.loading
                  ? Center(child: CircularProgressIndicator())
                  : buildUserCard(cardTitleWidget!, userInfoProvider.user);
            },
            child: ListTile(
              tileColor: Colors.yellow,
              title: Text("Profile",
                  style: const TextStyle(
                    color: AppThemes.listViewTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserCard(Widget cardTitle, UserModel? userModel) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          cardTitle,
          SizedBox(height: 20),
          Text(userModel?.id ?? ''),
          Text(userModel?.firstActivityAt.toString() ?? ''),
          Text(userModel?.lastActivityAt.toString() ?? ''),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
