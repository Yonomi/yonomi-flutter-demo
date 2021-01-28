import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'link-account.dart';

class IntegrationsWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final QueryOptions qo = QueryOptions(documentNode: gql(r'''
    query getAllIntegrations {
      integrations {
        edges {
          node {
            id
            displayName
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

          final GetIntegrationResponse response =
              GetIntegrationResponse.fromJson(result.data);
          print(response.integrations.edges.isNotEmpty);
          LinkAccountWidget linkAccountWidget;
          if (response.integrations.edges.isNotEmpty) {
            linkAccountWidget = LinkAccountWidget(
                response.integrations.edges.first.node.id,
                response.integrations.edges.first.node.displayName);
          }
          return Column(
            children: <Widget>[linkAccountWidget ?? Text('No Integrations')],
          );
        });
    return query;
  }
}

class GetIntegrationResponse {
  Integrations integrations;

  GetIntegrationResponse({this.integrations});

  GetIntegrationResponse.fromJson(Map<String, dynamic> json) {
    integrations = json['integrations'] != null
        ? new Integrations.fromJson(json['integrations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.integrations != null) {
      data['integrations'] = this.integrations.toJson();
    }
    return data;
  }
}

class Integrations {
  List<Edges> edges;

  Integrations({this.edges});

  Integrations.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = new List<Edges>();
      json['edges'].forEach((v) {
        edges.add(new Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Edges {
  Node node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node.toJson();
    }
    return data;
  }
}

class Node {
  String id;
  String displayName;

  Node({this.id, this.displayName});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    return data;
  }
}