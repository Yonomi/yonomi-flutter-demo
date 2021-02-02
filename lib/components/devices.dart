import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

class DevicesWidget extends StatelessWidget {
  static String title = "Devices";

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
          return Column(
            children: [
              Wrap(
                children: [
                  AppIcons(
                    imageUrl:
                        'https://play-lh.googleusercontent.com/yUNBzmUsCaG56OD58bag3SXx4VczzgwFOpJ4Ch_dkK1gyIyxOQ5TYUrB9cwFUGMj1dw=s360-rw',
                  )
                ],
              ),
              ListView(
                children: edges.map((e) {
                  final innerText = (e['node']['id'].toString());
                  List traits = e['node']['traits'];
                  String traitNames = traits.map((t) => t['name']).toString();
                  print(traitNames);
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
                              style:
                                  TextStyle(color: AppThemes.listViewTextColor),
                            ),
                            // Text('TRAITS:'),
                            Text(
                              'TRAITS:' + traitNames,
                              style:
                                  TextStyle(color: AppThemes.listViewTextColor),
                            )
                          ],
                        ),
                      ));
                }).toList(),
                // children: [Text(edges[0]['node']['createdAt'].toString())],
                shrinkWrap: true,
              )
            ],
          );
        });
    return query;
  }
}

class AppIcons extends StatelessWidget {
  final String imageUrl;

  const AppIcons({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(imageUrl),
    );
  }
}
