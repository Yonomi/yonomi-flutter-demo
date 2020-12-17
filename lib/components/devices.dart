import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DevicesWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final QueryOptions qo = QueryOptions(documentNode: gql(r'''
      query myDevices {
      me {
        devices {
          pageInfo { hasNextPage }
          edges {
            node {
              ... DeviceDetails
            }
          }
        }
      }
    }

    # fragments can be used to re-use parts of a query
    fragment DeviceDetails on Device {
      id
      createdAt
      traits {
        name instance
        ... on LockUnlockDeviceTrait {
          properties { supportsIsJammed }
          state {
            isLocked {
              reported { value sampledAt createdAt }
              desired { value delta updatedAt }
            }
          }
        }
        ... on PowerDeviceTrait {
          properties { supportsToggle supportsDiscreteOnOff }
          state {
            power {
              reported { value sampledAt createdAt }
              desired { value delta updatedAt }
            }
          }
        }
        ... on BrightnessDeviceTrait {
          properties { supportsRelativeBrightness }
          state {
            brightness {
              reported { value sampledAt createdAt }
              desired { value delta updatedAt }
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
          List edges = result.data['me']['devices']['edges'];
          print(edges);
          if (edges.isEmpty)
            return Center(
              child: Text('No Devices'),
            );
          return ListView(
            children: edges.map((e) {
              final innerText = (e['node']['id'].toString());
              List traits = e['node']['traits'];
              String traitNames = traits.map((t) => t['name']).toString();
              print(traitNames);
              return Container(
                  height: 50,
                  color: Colors.yellow[50],
                  child: Center(
                    child: Column(
                      children: [
                        Text(innerText),
                        // Text('TRAITS:'),
                        Text('TRAITS:' + traitNames)
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
