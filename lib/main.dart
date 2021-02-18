import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

import 'components/Home.dart';
import 'components/accounts.dart';
import 'components/devices.dart';
import 'components/integrations.dart';
import 'components/profile.dart';
import 'themes/string_constants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DevicesProvider>.value(
      value: YoSDKDevicesProvider(),
    ),
    ChangeNotifierProvider(create: (context) => UserInfoProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MaterialApp app = MaterialApp(
      title: 'Yonomi Flutter Demo',
      theme: AppThemes.getMainTheme(context),
      home: MyHomePage(title: 'Yonomi Demo App'),
    );
    return app;
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

  var _titles = [ProfileWidget.title, SettingsWidget.title];

  Function _navigateTo(BuildContext context) {
    return (int index) async {
      DevicesProvider provider =
          Provider.of<DevicesProvider>(context, listen: false);
      await provider.fetchDevices();
      if (index < _titles.length) {
        setState(() {
          _selectedIndex = index;
          widget.title = _titles[index];
        });
      }
    };
  }

  final Column homeWidget = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[HomeWidget()],
  );

  final Center integrationWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[IntegrationsWidget()],
    ),
  );

  final Column settingsWidget = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[ProfileWidget()],
  );

  @override
  Widget build(BuildContext context) {
    const BottomNavigationBarItem user = BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home', activeIcon: Icon(Icons.circle));
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
                  accounts,
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: AppThemes.bottomAppBarUnselectedItemColor,
                selectedItemColor: AppThemes.bottomAppBarSelectedItemColor,
                onTap: _navigateTo(context)),
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
