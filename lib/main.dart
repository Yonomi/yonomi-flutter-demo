import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yonomi_device_widgets/devices/lock.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_flutter_demo/assets/config_reader.dart';
import 'package:yonomi_flutter_demo/components/accounts.dart';
import 'package:yonomi_flutter_demo/components/dynamic_devices.dart';
import 'package:yonomi_flutter_demo/components/home.dart';
import 'package:yonomi_flutter_demo/components/integration_list.dart';
import 'package:yonomi_flutter_demo/components/login_screen.dart';
import 'package:yonomi_flutter_demo/components/profile.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/components/yonomi_bottom_app_bar.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/login_provider.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';
import 'package:yonomi_flutter_demo/themes/string_constants.dart';
import 'package:yonomi_flutter_demo/utils/loggers/crashlytics_logger_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(YoAppWithLoginPage());
}

class YoAppWithLoginPage extends StatelessWidget {
  Map? _configMap;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.app_title,
      theme: AppThemes.getMainTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => FutureBuilder<Map>(
            future: Config.readFromConfigFile(),
            builder: (context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                CrashlyticsLoggerWrapper.instance.logException(
                    snapshot.error, snapshot.stackTrace,
                    reason: 'Error reading config files');
                return Text("App couldn't initialize");
              } else if (snapshot.hasData) {
                _configMap ??= snapshot.data!;
                return LoginScreen(
                  _configMap!,
                  FlutterAppAuth(),
                  FlutterSecureStorage(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        'app': (context) => YoApp(configuration: _configMap),
        'lockDetailPage': (context) => Scaffold(
            extendBodyBehindAppBar: false,
            appBar: YonomiAppBar(
              StringConstants.default_app_bar_title,
              onPressed: () {},
            ),
            body: Lock(
              deviceId: (ModalRoute.of(context)!.settings.arguments as List)[0],
              request: (ModalRoute.of(context)!.settings.arguments as List)[1],
            )),
        'traitDetailPage': (context) => Scaffold(
            extendBodyBehindAppBar: false,
            appBar: YonomiAppBar(
              '${(ModalRoute.of(context)!.settings.arguments as List)[2]} Traits',
              onPressed: () {},
            ),
            body: DetailScreen(
              deviceId: (ModalRoute.of(context)!.settings.arguments as List)[0],
              request: (ModalRoute.of(context)!.settings.arguments as List)[1],
            ))
      },
    );
  }
}

class YoApp extends StatelessWidget {
  final Map? configuration;

  const YoApp({Key? key, this.configuration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String accessToken =
        ModalRoute.of(context)!.settings.arguments as String;
    final LoginProvider loginProvider = LoginProvider(
      accessToken,
      configuration![Config.URL],
    );
    return MultiProvider(
      providers: [
        Provider<LoginProvider>.value(value: loginProvider),
        ChangeNotifierProvider<DevicesProvider>(
          create: (context) => DevicesProvider(loginProvider.request),
        ),
        ChangeNotifierProvider(
            create: (context) => UserInfoProvider(loginProvider.request)),
      ],
      child: YonomiHomePage(
        title: StringConstants.app_title,
      ),
    );
  }
}

class YonomiHomePage extends StatefulWidget {
  YonomiHomePage({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  _YonomiHomePageState createState() => _YonomiHomePageState();
}

class _YonomiHomePageState extends State<YonomiHomePage> {
  int _selectedIndex = 0;

  var _titles = [
    ProfileWidget.title,
    SettingsWidget.title,
    SettingsWidget.title,
    'Dynamic Devices',
  ];

  Function _navigateTo(BuildContext context) {
    return (int index) async {
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

  final Column settingsWidget = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[ProfileWidget()],
  );

  final Column dynamicDevicesWidget = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[DynamicDevices()],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: YonomiAppBar(
        widget.title!,
        onPressed: () {},
      ),
      body: [
        homeWidget,
        homeWidget,
        settingsWidget,
        dynamicDevicesWidget
      ][_selectedIndex],
      bottomNavigationBar: YonomiBottomAppBar(
        selectedIndex: _selectedIndex,
        onTap: _navigateTo(context) as void Function(int)?,
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
            onPressed: () {
              var userInfoProvider =
                  Provider.of<UserInfoProvider>(context, listen: false);
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Center(
                        heightFactor: 1.0,
                        child: IntegrationList(
                          integrations: userInfoProvider.fetchIntegrations(),
                          onPress: (integrationId) async {
                            Navigator.of(context, rootNavigator: true).pop();
                            _launchURL(await userInfoProvider
                                .fetchUrl(integrationId!));
                          },
                        ),
                      ),
                    );
                  });
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
