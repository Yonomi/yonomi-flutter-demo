import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProfileWidget extends StatelessWidget {
  static String title = "Home";

  Widget build(BuildContext context) {
    final QueryOptions qo = QueryOptions(documentNode: gql(r'''
      query basicInfo {
        # "me" is the entry point to any data specific to the current user
        me {
          id
          lastActivityAt
          firstActivityAt
        }

        # basic information about the tenant
        tenant {
          id
          displayName
        }
      }'''));
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 25),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      tileColor: Colors.yellow,
                      title: Text("Tenant Information",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          )),
                    ),
                    Text(result.data['tenant']['displayName']),
                    Text(result.data['tenant']['id']),
                    SizedBox(height: 20)
                  ],
                ),
              ),
              SizedBox(height: 25),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      tileColor: Colors.yellow,
                      title: Text("Profile",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          )),
                    ),
                    Text(result.data['me']['id']),
                    Text(result.data['me']['lastActivityAt']),
                    Text(result.data['me']['firstActivityAt']),
                    SizedBox(
                        height:
                            20) // Text(result.data['me']['firstActivityAt']),
                  ],
                ),
              ),
              // Expanded(
              //     child: Container(
              //   width: 100,
              // ))
            ],
          );
        });
    return query;
  }
}
