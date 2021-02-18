import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

import 'components/Home.dart';
import 'components/accounts.dart';
import 'components/devices.dart';
import 'components/integrations.dart';
import 'components/profile.dart';
import 'themes/string_constants.dart';

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
          create: (context) => UserInfoProvider(),
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
    SettingsWidget.title
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
    const Widget dotIcon = Icon(
      Icons.circle,
      size: 10,
      color: AppThemes.bottomAppBarUnselectedItemColor,
    );

    Widget homeIcon = SvgPicture.asset(
      'assets/icons/ic_home_unselected.svg',
      color: AppThemes.bottomAppBarUnselectedItemColor,
      semanticsLabel: "home",
    );

    Widget devicesIcon = SvgPicture.asset(
      'assets/icons/ic_routines_unselected.svg',
      color: AppThemes.bottomAppBarUnselectedItemColor,
      semanticsLabel: "devices",
    );

    Widget settingsIcon = SvgPicture.asset(
      'assets/icons/ic_settings_unselected.svg',
      color: AppThemes.bottomAppBarUnselectedItemColor,
      semanticsLabel: "settings",
    );

    Widget homeUnselectedWidget = Column(
      children: [homeIcon, const Text("HOME")],
    );

    Widget homeSelectedWidget = Column(
      children: [const Text("HOME"), dotIcon],
    );

    Widget devicesUnselectedWidget = Column(
      children: [devicesIcon, const Text("DEVICES")],
    );

    Widget devicesSelectedWidget = Column(
      children: [const Text("DEVICES"), dotIcon],
    );

    Widget settingsUnselectedWidget = Column(
      children: [settingsIcon, const Text("SETTINGS")],
    );

    Widget settingsSelectedWidget = Column(
      children: [const Text("SETTINGS"), dotIcon],
    );

    BottomNavigationBarItem userItem = BottomNavigationBarItem(
      icon: homeUnselectedWidget,
      activeIcon: homeSelectedWidget,
      title: SizedBox.shrink(),
    );

    BottomNavigationBarItem devicesItem = BottomNavigationBarItem(
      icon: devicesUnselectedWidget,
      activeIcon: devicesSelectedWidget,
      title: SizedBox.shrink(),
    );

    BottomNavigationBarItem accountsItem = BottomNavigationBarItem(
      icon: settingsUnselectedWidget,
      activeIcon: settingsSelectedWidget,
      title: SizedBox.shrink(),
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
          notchMargin: 10.0,
          child: Container(
            padding: EdgeInsets.only(right: 90.0),
            child: BottomNavigationBar(
                key: Key('bottomNavBar'),
                elevation: 0,
                backgroundColor: Colors.transparent,
                items: <BottomNavigationBarItem>[
                  userItem,
                  devicesItem,
                  accountsItem,
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: AppThemes.bottomAppBarUnselectedItemColor,
                selectedItemColor: AppThemes.bottomAppBarSelectedItemColor,
                onTap: _navigateTo),
          )),
      floatingActionButtonLocation: const offsetFromEndDockedFabLocation(),
      floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
              child: FloatingActionButton(
            backgroundColor: AppThemes.floatingActionButtonColor,
            elevation: 2.0,
            tooltip: StringConstants.add_account,
            child: Icon(
              Icons.add,
              size: 45,
            ),
          ))),
    );
  }
}

class offsetFromEndDockedFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabDockedOffsetY {
  const offsetFromEndDockedFabLocation();

  @override
  String toString() => 'FloatingActionButtonLocation.endDocked';

  @override
  double getOffsetX(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? -13.0 : 13.0;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}
