import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

class AccountsWidget extends StatelessWidget {
  static final String title = "Settings";

  Widget build(BuildContext context) {
    final Widget userQuery = getUserQueryWidget();
    final Widget accountsQuery = getAccountsQueryWidget();

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 25),
          userQuery,
          SizedBox(height: 25),
          accountsQuery,
        ]);
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

  Query getAccountsQueryWidget() {
    final QueryOptions qo = QueryOptions(documentNode: gql(r'''
      query linkedAccounts {
        me {
          id
          lastActivityAt
          firstActivityAt
          linkedAccounts {
            edges {
              node {
                id
                status
                createdAt
                integration {
                  id
                  displayName
                }
              }
            }
          }
        }
      }
      '''));
    final Query query = Query(
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
          List edges = [];
          if (result.data['me']['linkedAccounts'] != null) {
            edges = result.data['me']['linkedAccounts']['edges'];
          }
          if (edges.isEmpty)
            return Center(
              child: Text('No Accounts'),
            );
          return ListView(
            children: edges.map((e) {
              final innerText = (e['node']['integration']['displayName']);
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
        });
    return query;
  }
}
