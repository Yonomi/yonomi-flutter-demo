import 'package:flutter/material.dart';

class DeviceModel extends ChangeNotifier {
  final String _id;

  DeviceModel(this._id);

  String get id => _id;
}
