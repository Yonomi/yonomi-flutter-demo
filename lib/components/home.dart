import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/components/devices.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

class HomeWidget extends StatelessWidget {
  static final String title = "Home";

  Widget build(BuildContext context) {
    final Widget userQuery = getUserQueryWidget();
    final Widget deviceQuery = getDeviceQueryWidget();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: 25),
        userQuery,
        SizedBox(height: 25),
        deviceQuery,
        // Expanded(
        //     child: Container(
        //   width: 100,
        // ))
      ],
    );
  }

  Query getUserQueryWidget() {
    final QueryOptions qo = QueryOptions(documentNode: gql(r'''
      query basicInfo {
        # "me" is the entry point to any data specific to the current user
        me {
          id
          lastActivityAt
          firstActivityAt
        }
      }'''));
    return Query(
        options: qo,
        builder: (
          QueryResult result, {
          Future<QueryResult> Function() refetch,
          FetchMore fetchMore,
        }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                Text(result.data['me']['id']),
                Text(result.data['me']['lastActivityAt']),
                Text(result.data['me']['firstActivityAt']),
                SizedBox(
                    height: 20) // Text(result.data['me']['firstActivityAt']),
              ],
            ),
          );
        });
  }

  Widget getDeviceQueryWidget() {
    final DevicesWidget devicesWidget = DevicesWidget();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.yellow,
            title: Text("Devices",
                style: const TextStyle(
                  color: AppThemes.listViewTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                )),
          ),
          SizedBox(height: 20),
          devicesWidget,
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
