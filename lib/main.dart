import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/accountModel.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

import 'components/Home.dart';
import 'components/accounts.dart';
import 'components/devices.dart';
import 'components/integrations.dart';
import 'themes/StringConstants.dart';
import 'components/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final HttpLink httpLink = HttpLink(
    //   uri: 'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql',
    // );

    // final String token =
    //     'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTI5NTc1MzYsImV4cCI6MTYxMzA0MzkzNn0.lPrkNHutuISp01vujaRHFGFXlyYIcCLYhRhIOhLjMUssn95rb6KMP4Jd-Y3u1yloxkZkFRapnofAVp6HSdGodwqLDBbeoklEc-PMaNiU7auV2OmIzC825kt8HT_8_SU7ErGT4zSRPdJ8i927xl7lQuXi4FpzoDKKwmLr8dJe5joIu0qg2qKshknnUI7qgZ6IZdofFeX3I-MBkxoabbexqhF_OS-oT2wHJqOYK-7sTZ3iW2g165_ol9ud4j-uUCdbii4SvA3zpgB50YrafRYbZjktC9g5d09XBQs0YjmllZfGF1RbImZVzTWSFMDx7-RmNq61h3TYyHQrEFBcXR1-0Q';
    // final AuthLink authLink = AuthLink(
    //   getToken: () async => 'Bearer ' + token,
    // );

    // final Link link = authLink.concat(httpLink);
    // final GraphQLClient gqlClient = GraphQLClient(
    //   cache: InMemoryCache(),
    //   link: link,
    // );

    // ValueNotifier<GraphQLClient> client = ValueNotifier(gqlClient);

    final MaterialApp app = MaterialApp(
      title: 'Yonomi Flutter Demo',
      theme: AppThemes.getMainTheme(context),
      home: MyHomePage(title: 'Yonomi Demo App'),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AccountModel('DisplayName'),
        )
      ],
      child: app,
    );
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
    if (index < _titles.length) {
      setState(() {
        _selectedIndex = index;
        widget.title = _titles[index];
      });
    }
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
    children: <Widget>[SettingsWidget()],
  );

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.title),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications,
                color: AppThemes.appBarAlertIconColor),
            onPressed: () {},
          )
        ],
      ),
      body: [
        homeWidget,
        devicesWidget,
        settingsWidget,
      ][_selectedIndex],
      bottomNavigationBar: BottomAppBar(
          color: AppThemes.bottomAppBarBgColor,
          shape: AutomaticNotchedShape(
              RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
          notchMargin: 8.0,
          child: Container(
            padding: EdgeInsets.only(right: 90.0),
            child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                items: const <BottomNavigationBarItem>[
                  user,
                  devices,
                  accounts,
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: AppThemes.bottomAppBarUnselectedItemColor,
                selectedItemColor: AppThemes.bottomAppBarSelectedItemColor,
                onTap: _navigateTo),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemes.floatingActionButtonColor,
        elevation: 2.0,
        tooltip: StringConstants.add_account,
        child: Icon(Icons.add),
      ),
    );
  }
}
