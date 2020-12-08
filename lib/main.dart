import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/graphql/basic_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'https://x9pob7epve.execute-api.us-east-1.amazonaws.com/dev/graphql',
    );

    final String token =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYjUxZWNjNC01OWEzLTRiOWQtYmQ0Yy04YzUxYTczZGEwYTYiLCJpc3MiOiJkNmFjYzA1Yi1jNzk5LTQ5OGMtYWJhZS00ZTU5OWJjMzQyNDkiLCJpYXQiOjE2MDczNjIxNzksImV4cCI6MTYwNzQ0ODU3OX0.wbCVUEP4gQwFQXP-a9_VRFH1JWEjZd_L-tSEUhAabt7_p8u0CTTGgDLJtU7QifCfwvxOtdEx8CpLgyhJaqg6XaeiTAOyVFwXHuHSGGLCeTE3KulfZU1zSLkohhVBXMtkrf-4h6bSqZK76n5qYYcyQ91WXQZj9augq-6RueGRQEHWne_6-tXA5f9zji-ZEdRIQhO2Mr9A5CAiMjPpa5wLgDG77WlYzN_zYG6-LWDtGmL_4_sx8Pks1rBL6qtk-ARG4Txr6E9hsW31qWU2K9JxB_F1h897hci4PPaKbRGguxscYpBrK130w646R7UkzUht2qjEhTFPQQMcAiE6Lsn9Nw';
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: [userWidget, devicesWidget][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[user, devices],
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
