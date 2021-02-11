import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkAccountWidget extends StatelessWidget {
  String id;
  String name;

  LinkAccountWidget(String id, String name) {
    this.id = id;
    this.name = name;
  }

  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      onPressed: () => print('pressed button'),
      child: Text(this.name),
    );
  }
}
