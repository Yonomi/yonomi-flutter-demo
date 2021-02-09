import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

import 'components/accounts.dart';
import 'components/devices.dart';
import 'components/integrations.dart';
import 'components/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql',
    );

    final String token =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTI3OTk0ODUsImV4cCI6MTYxMjg4NTg4NX0.un47JPVJPpv2V19oLWD0zii_hGNNRbnnyzVFd9xzkvr04YzdODOtdXgXeLArNlfwzyynuiJLIiyoPFXPcbNcNX4kEOy-6uxaGDV39p3XOZoPwGdEJd5jwY6VvGqKtNfV40XpTmGGW_3aaq8RHGwRq0EfgNTHqUo9fydkJAOr3v9Rreuk4P985tOUbirY4_LMApshXY-1kq8aBLro7VzfPeFsPTrJhs2dIY1DERE9yNAYgxDBKfqFIMqn8KxmGCDli70dMMglGl4Q7hnkW5g0r0F0FymNoeK7JcPcHocAuxJv92KhKSuPEuUPbEwdrQwGD8IZWUpncrsF0vW42tggBw';
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

  var _titles = [
    ProfileWidget.title,
    DevicesWidget.title,
    AccountsWidget.title
  ];

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
      widget.title = _titles[index];
    });
  }

  final Column homeWidget = Column(
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
        appBar: AppBar(
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
