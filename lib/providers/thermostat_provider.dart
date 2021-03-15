import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/repository/devices_repository.dart';

class ThermostatProvider extends ChangeNotifier {
  final request = YoRequestCreator.request();

  Future<void> setPointAction(String deviceId, double temperature) async {
    DevicesRepository.setPointThermostat(request, deviceId, temperature);
  }
}
