import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkAccountWidget extends StatelessWidget {
  String id;
  String name;

  LinkAccountWidget(String id, String name) {
    this.id = id;
    this.name = name;
  }

  Widget build(BuildContext context) {
    final MutationOptions mop = MutationOptions(
        documentNode: gql(r'''
        mutation generateAccountLinkingUrl ($integrationId: ID!) {
          generateAccountLinkingUrl(integrationId: $integrationId) {
            url
            integration {
              id
              displayName
            }
          }
        }
        '''),
        onCompleted: (dynamic resultData) async {
          String url = resultData['generateAccountLinkingUrl']['url'];
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        });
    final Mutation mutation = Mutation(
      options: mop,
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () => runMutation({
            'integrationId': this.id,
          }),
          child: Text(this.name),
        );
      },
    );
    return mutation;
  }
}
