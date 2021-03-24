import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/graphql/devices/thermostat/thermostat_queries.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';
import 'package:yonomi_platform_sdk/repository/devices/thermostat_repository.dart';

class ThermostatProvider extends ChangeNotifier {
  ThermostatProvider(String deviceId) {
    getDeviceDetail(deviceId);
  }

  final request = YoRequestCreator.request();
  Device _deviceDetail;

  Future<void> setPointAction(String deviceId, double temperature) async {
    ThermostatRepository.setPointThermostat(request, deviceId, temperature);
  }

  Future<void> setThermostatMode(String deviceId, ThermostatMode mode) async {
    ThermostatRepository.setMode(request, deviceId, mode);
  }

  Future<Device> getDeviceDetail(String deviceId) async {
    _deviceDetail =
        await DevicesRepository.getThermostatDetails(request, deviceId);
    notifyListeners();
  }

  Device get deviceDetail => _deviceDetail;

  double get thermostatTargetTemperature =>
      _deviceDetail?.traits?.first?.state?.value ?? 0;
}
