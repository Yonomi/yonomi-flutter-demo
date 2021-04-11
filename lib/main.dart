import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

import 'components/Home.dart';
import 'components/accounts.dart';
import 'components/integrations.dart';
import 'components/login_screen.dart';
import 'components/profile.dart';
import 'components/yonomi_app_bar.dart';
import 'components/yonomi_bottom_app_bar.dart';
import 'themes/string_constants.dart';

const integrationId = 'f0885113-68bb-4bb5-af50-0cbd51025ea9';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(YoAppWithLoginPage());
}

class YoAppWithLoginPage extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yonomi Flutter Demo',
      theme: AppThemes.getMainTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text("App couldn't initialize");
              } else if (snapshot.hasData) {
                return LoginScreen();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        'app': (context) => YoApp()
      },
    );
  }
}

class YoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context).settings.arguments as String;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesProvider>.value(
          value: YoSDKDevicesProvider(userId),
        ),
        ChangeNotifierProvider(create: (context) => UserInfoProvider(userId)),
      ],
      child: YonomiHomePage(title: 'Yonomi Demo App'),
    );
  }
}

class YonomiHomePage extends StatefulWidget {
  YonomiHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _YonomiHomePageState createState() => _YonomiHomePageState();
}

class _YonomiHomePageState extends State<YonomiHomePage> {
  int _selectedIndex = 0;

  var _titles = [
    ProfileWidget.title,
    SettingsWidget.title,
    SettingsWidget.title
  ];

  Function _navigateTo(BuildContext context) {
    return (int index) async {
      DevicesProvider provider =
          Provider.of<DevicesProvider>(context, listen: false);
      await provider.hydrateDevices();
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
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: YonomiAppBar(
        widget.title,
        onPressed: () {},
      ),
      body: [homeWidget, settingsWidget, settingsWidget][_selectedIndex],
      bottomNavigationBar: YonomiBottomAppBar(
        selectedIndex: _selectedIndex,
        onTap: _navigateTo(context),
      ),
      floatingActionButtonLocation: const OffsetFromEndDockedFabLocation(),
      floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
              child: FloatingActionButton(
            backgroundColor: AppThemes.floatingActionButtonColor,
            elevation: 2.0,
            tooltip: StringConstants.add_account,
            onPressed: () async {
              var userInfoProvider =
                  Provider.of<UserInfoProvider>(context, listen: false);
              _launchURL(await userInfoProvider.fetchUrl(integrationId));
            },
            child: Icon(
              Icons.add,
              size: 45,
            ),
          ))),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class OffsetFromEndDockedFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabDockedOffsetY {
  const OffsetFromEndDockedFabLocation();

  @override
  String toString() => 'FloatingActionButtonLocation.endDocked';

  @override
  double getOffsetX(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? -2.0 : 2.0;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}
