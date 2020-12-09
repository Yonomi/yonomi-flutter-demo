import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/graphql/basic_info.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

const String successPageMessage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
Account link succeeded
</p>
</body>
</html>
''';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'https://x00m1goyc1.execute-api.us-east-1.amazonaws.com/dev/graphql',
    );

    final String token =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1MTAzZmZkYi1mZjVmLTRhNjktODQyMi0yNTllYTVhMTQzZTUiLCJpc3MiOiJkYTQ0MWNiOC1kNzA4LTRkM2ItYjIyMS1mMGNlZjQyN2UzZWMiLCJpYXQiOjE2MDc0NjM1NzcsImV4cCI6MTYwNzU0OTk3N30.WgBfMcu_U93SFYz1fmgYIYY4x60GSiPDFygsUbPGniIzxSENsQSv4TcCptH-OLgzqvwByhHU_TUotV2ruCMqoFeZ41amlvxKyGQD-prnta2pChRBPrkZZsRVKZNIfOTpnm7C4DYW9_sA_o7EIJibCBBq4LEJO43lC12KjBndDtB6OUmsj3vusuBzLPhgCWPV8ZtiWyFW2jAcAuELZo9noTyY4OwWjf-LrOdtC9rFOXks6UgpgNJNMFvOmlQQjZzy_TgglqlNwwFBUtQc2QBM_6yyg9GVEGxt0XzywgJCVrIlBywWIEnESUInLbuIRC3kJUamIYhc8cktpiKf46nXuA';
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ' + token,
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );

    final Link link = authLink.concat(httpLink);
    final GraphQLClient gqlClient = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(gqlClient);

    final MaterialApp app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );

    return GraphQLProvider(client: client, child: app);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Center userWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[GraphCall()],
    ),
  );

  final Center devicesWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[GraphCallDevices()],
    ),
  );

  final Center integrationWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[GraphCallIntegrations()],
    ),
  );

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const BottomNavigationBarItem user = BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'User',
    );
    const BottomNavigationBarItem devices = BottomNavigationBarItem(
      icon: Icon(Icons.handyman),
      label: 'Devices',
    );
    const BottomNavigationBarItem integrations = BottomNavigationBarItem(
      icon: Icon(Icons.power),
      label: 'Integrations',
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: [userWidget, devicesWidget, integrationWidget][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[user, devices, integrations],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _navigateTo)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class GraphCall extends StatelessWidget {
  Widget build(BuildContext context) {
    final QueryOptions qo =
        QueryOptions(documentNode: BasicInfoQuery().document);
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
            children: <Widget>[
              Text(JsonEncoder.withIndent('  ').convert(result.data)),
            ],
          );
        });
    return query;
  }
}

class GraphCallDevices extends StatelessWidget {
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

    # you can use the "filter" parameter to only find devices that have at least
    # one matching trait in the filter

    query allDevicesWithPower {
      me {
        devices (filter: { traits: [POWER] }) {
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
          print(result.data);
          return Column(
            children: <Widget>[
              Text(JsonEncoder.withIndent('  ').convert(result.data)),
            ],
          );
        });
    return query;
  }
}

class GraphCallIntegrations extends StatelessWidget {
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
          print(result.data);
          final GetIntegrationResponse response =
              GetIntegrationResponse.fromJson(result.data);
          return Column(
            children: <Widget>[
              GraphCallLoginButton(response.integrations.edges[0].node.id,
                  response.integrations.edges[0].node.displayName),
            ],
          );
        });
    return query;
  }
}

// ignore: must_be_immutable
class GraphCallLoginButton extends StatelessWidget {
  String id;
  String name;

  GraphCallLoginButton(String id, String name) {
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
        onCompleted: (dynamic resultData) {
          String url = resultData['generateAccountLinkingUrl']['url'];
          print(url);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                      appBar: AppBar(),
                      body: Column(
                        children: [
                          Expanded(
                              child: WebView(
                                  javascriptMode: JavascriptMode.unrestricted,
                                  initialUrl: url,
                                  gestureNavigationEnabled: true))
                        ],
                      ))));
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

class LoginWebView extends StatefulWidget {
  @override
  LoginWebViewState createState() => LoginWebViewState();
}

class LoginWebViewState extends State<LoginWebView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
