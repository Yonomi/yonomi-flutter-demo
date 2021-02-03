import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

import 'components/Home.dart';
import 'components/accounts.dart';
import 'components/devices.dart';
import 'components/integrations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: '',
    );

    final String token = '';
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ' + token,
    );

    final Link link = authLink.concat(httpLink);
    final GraphQLClient gqlClient = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(gqlClient);

    final MaterialApp app = MaterialApp(
      title: 'Yonomi Flutter Demo',
      theme: AppThemes.getMainTheme(context),
      home: MyHomePage(title: 'Yonomi Demo App'),
    );

    return GraphQLProvider(client: client, child: app);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  var _titles = [HomeWidget.title, DevicesWidget.title, AccountsWidget.title];

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
      widget.title = _titles[index];
    });
  }

  final Column homeWidget = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[HomeWidget()],
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

  final Column settingsWidget = Column(
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
      icon: Icon(Icons.home),
      label: 'Home',
    );
    const BottomNavigationBarItem devices = BottomNavigationBarItem(
      icon: Icon(Icons.handyman),
      label: 'Devices',
    );
    const BottomNavigationBarItem accounts = BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings),
      label: 'Settings',
    );
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title),
          centerTitle: false,
        ),
        body: [homeWidget, devicesWidget, settingsWidget][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[user, devices, accounts],
            currentIndex: _selectedIndex,
            unselectedItemColor: AppThemes.bottomAppBarUnselectedItemColor,
            selectedItemColor: AppThemes.bottomAppBarSelectedItemColor,
            onTap: _navigateTo));
  }
}
