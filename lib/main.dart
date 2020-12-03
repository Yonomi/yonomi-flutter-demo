import 'package:artemis/artemis.dart';
import 'package:flutter/material.dart';
import 'graphql/graphql_api.dart';
import 'package:http/http.dart' as http;

class AuthorizedClient extends http.BaseClient{
  http.Client _httpClient = new http.Client();

  var token;

  AuthorizedClient(this.token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({'Authorization': 'Bearer ${token}'});
    return _httpClient.send(request);
  }
}

Future<void> runGraphQL() async {
  final graphqlEndpoint = "https://1ylvczhwa9.execute-api.us-east-1.amazonaws.com/dev/graphql";

  final blaClient = AuthorizedClient("eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ZDZhOGIwMC0yZTg5LTQ1MjItOGIyMi05ZDYyZTc1NmZmNDMiLCJpc3MiOiI2YjhiNGE4Zi0zNDIxLTQyMDEtYTZjMi0yZjY3OWI3NGMxODgiLCJpYXQiOjE2MDcwMzExMTMsImV4cCI6MTYwNzExNzUxM30.vhLipgiiLEhysSuk0v-7S_7Cgm19saUGRMMemJVklZdDlf5N4XTAQB3d87ir2YT_qmoLag27daypWM5aj88rtZheXtHYfOKYN78aDoD2gdx60qrfl4a4427gJ4-EJNprgz637HrUjOPBtJMpRVwH7GrvqK4mF3DrLRPkmnmeUKGlMC8yMdYCALOVyYAw8Zhtw_eoBs0HvybFkkd4hqiIy7yAIvrJwVrp3wA4vNVVeLAM5STF9V65ILFXHcjEJwi6nPTiBKd3bu1v16qdHTDRkbMJs99Nz_Dy7OtiGC1jMvguxo5mCXf8xOIVTLjWctKk64VnwUPvKu7nZVpuwsX5cw");
  final client = ArtemisClient(graphqlEndpoint, httpClient: blaClient);
  
  final basicInfoQuery = BasicInfoQuery();

  final basicInfoQueryResponse = await client.execute(basicInfoQuery);
  client.dispose();

  print("Basic Query response: me.id: ${basicInfoQueryResponse.data.me.id}");
}

void main() {
  runGraphQL();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
