import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/graphql/basic_info.dart';
import 'package:yonomi_flutter_demo/graphql/basic_info.graphql.dart';

class TenantSectionWidget extends StatelessWidget {
  final String tenantId;
  final String tenantName;
  
  TenantSectionWidget({this.tenantId, this.tenantName});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("Tenant Id: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
              Text(tenantId, style: TextStyle(fontSize: 16))),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("Tenant Name: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
              Text(tenantName, style: TextStyle(fontSize: 16))),
            ]),
      ],
    );
  }
  
}
class StatefulTenantSectionWidget extends StatefulWidget {
  final String tenantId;
  final String tenantName;

  const StatefulTenantSectionWidget({this.tenantId, this.tenantName});

  @override
  _StatefulTenantSectionWidgetState createState() => _StatefulTenantSectionWidgetState();
}

class _StatefulTenantSectionWidgetState extends State<StatefulTenantSectionWidget> {
  String tenantId = "";
  String tenantName = "";

  @override
  void initState() {
    tenantId = widget.tenantId;
    tenantName = widget.tenantName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
                Text("Tenant Id: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
                Text(tenantId, style: TextStyle(fontSize: 16))),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
                Text("Tenant Name: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
                Text(tenantName, style: TextStyle(fontSize: 16))),
            ]),
      ],
    );
  }
}


class idSectionWidget extends StatefulWidget {
  final String userId;

  idSectionWidget({this.userId});

  @override
  _idSectionWidgetState createState() => _idSectionWidgetState();
}

class _idSectionWidgetState extends State<idSectionWidget> {
  TextEditingController userIdController;

  String userId;

  @override
  void initState() {
    userId = widget.userId;
    super.initState();
    userIdController = new TextEditingController(text: userId);

    userIdController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    userIdController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Text field value: ${userIdController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("User Id: ", style: TextStyle(fontSize: 20))),
              Flexible(child:
              TextField(

                controller: userIdController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a User ID'
                ),
              )
              ),
            ])
    );
  }

}

class ActivitySectionWidget extends StatelessWidget {
  final String userId;
  final DateTime userFirstActivity;
  final DateTime userLastActivity;

  const ActivitySectionWidget({this.userId, this.userFirstActivity, this.userLastActivity});

  @override
  Widget build(BuildContext context) {
      return Column(children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("User Id: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
              Text(userId, style: TextStyle(fontSize: 16))),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("User First Activity: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
              Text(userLastActivity.toString(), style: TextStyle(fontSize: 16))),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("User Last Activity: ", style: TextStyle(fontSize: 20))),
              Expanded(child:
              Text(userFirstActivity.toString(), style: TextStyle(fontSize: 16))),
            ]),
      ],);
  }

}

class StatefulUserScreenWidget extends StatefulWidget {
  @override
  _StatefulUserScreenWidgetState createState() => _StatefulUserScreenWidgetState();
}

class _StatefulUserScreenWidgetState extends State<StatefulUserScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: BasicInfoQuery().document),
      builder: (
          QueryResult result, {
            Refetch refetch,
            FetchMore fetchMore
          }) {
            if(result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.loading && result.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final basicInfo = BasicInfo$Query.fromJson(result.data);
            final tenantId = basicInfo.tenant.id;
            final tenantName = basicInfo.tenant.displayName;

            final userId = basicInfo.me.id;
            final userFirst = basicInfo.me.firstActivityAt;
            final userLast = basicInfo.me.lastActivityAt;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TenantSectionWidget(tenantId: tenantId, tenantName: tenantName),
                idSectionWidget(userId: userId),
                ActivitySectionWidget(
                  userId: userId,
                  userFirstActivity: userFirst,
                  userLastActivity: userLast,
                )
              ],
            );
      },
    );
  }

}