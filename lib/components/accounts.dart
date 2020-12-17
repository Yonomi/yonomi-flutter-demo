import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AccountsWidget extends StatelessWidget {
  Widget build(BuildContext context) {
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
                  color: Colors.yellow[50],
                  child: Center(
                    child: Column(
                      children: [Text(innerText)],
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
