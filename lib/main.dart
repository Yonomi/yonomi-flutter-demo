import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'components/profile.dart';
import 'components/devices.dart';
import 'components/integrations.dart';
import 'components/accounts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'https://lui95yypaj.execute-api.us-east-1.amazonaws.com/dev/graphql',
    );

    final String token =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTYzZDU0My03MzQ4LTRhNmYtOTM2OC1iODllZjdiZDU0YzIiLCJpc3MiOiIyMjdhZGZjMS03NzhjLTQyYzEtODYxZi00N2U3MmIyYTgzYjQiLCJpYXQiOjE2MDgyMzI4NTcsImV4cCI6MTYwODMxOTI1N30.LUmGyUeZ5JQ_vJVtV0nK521b9vEOnjbMH-kxpT7B-mIh6yZ7TfvEk7R3aIb3teugisEjxsZLIjulrQR8jnHxOtRT7ir0zYdPTESJflqK3Tr6GygMn6RRnUZbl9wxAtNiirOeGrY4R8klKCRNn705pEh8HOW4SsgNBsn5myqcB-n43Owo8lo_WrWeGFpMLT9Lt_7PRmp-bR-EYfBOjrfMEkWiZ0xrELtOcMX0-J_4ZBZe7R4SvQoLQJiYaCGonej3iWPxoPh4qXQwPI8bpbtvSylQMkbE8AEdgkju0ZX0lxsd43rf9PtilfpEmOZeJAZElSbcDDcUlhL19vbKTVHApQ';
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
        primarySwatch: Colors.yellow,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Wander Jaunt'),
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

  final Column userWidget = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[ProfileWidget()],
  );

  final Column devicesWidget = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[DevicesWidget()],
  );

  final Center integrationWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[IntegrationsWidget()],
    ),
  );

  final Column accountsWidget = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[AccountsWidget()],
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
      icon: Icon(Icons.add),
      label: 'Integrations',
    );
    const BottomNavigationBarItem accounts = BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings),
      label: 'Accounts',
    );
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: [
          userWidget,
          devicesWidget,
          integrationWidget,
          accountsWidget
        ][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              user,
              devices,
              integrations,
              accounts
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.black38,
            selectedItemColor: Colors.amber[800],
            onTap: _navigateTo)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
