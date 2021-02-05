import 'package:flutter/widgets.dart';

class DeviceItemModel extends ChangeNotifier {
  String _deviceLocation;
  String _deviceName;
  String _deviceState;

  DeviceItemModel({String location, String name, String state}) {
    _deviceLocation = location ?? "No location set";
    _deviceName = name ?? "No name";
    _deviceState = state ?? "Unknown";
  }

  String get deviceLocation => _deviceLocation;

  String get deviceName => _deviceName;

  String get deviceState => _deviceState;

  set deviceLocation(String loc) {
    _deviceLocation = loc;
    notifyListeners();
  }

  set deviceName(String name) {
    _deviceName = name;
    notifyListeners();
  }

  set deviceState(String state) {
    _deviceState = state;
    notifyListeners();
  }
}
