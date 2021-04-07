import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/graphql/devices/thermostat/thermostat_queries.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';
import 'package:yonomi_platform_sdk/repository/devices/thermostat_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class ThermostatProvider extends ChangeNotifier {
  ThermostatProvider(String deviceId, String userId) {
    _userId = userId;
    getDeviceDetail(deviceId);
  }

  String _userId;
  Device _deviceDetail;
  Request _request;

  Future<void> setPointAction(String deviceId, double temperature) async {
    if (_request == null) {
      _request = await YoRequest.request(_userId);
    }
    ThermostatRepository.setPointThermostat(_request, deviceId, temperature);
  }

  Future<void> setThermostatMode(String deviceId, ThermostatMode mode) async {
    ThermostatRepository.setMode(_request, deviceId, mode);
  }

  Future<Device> getDeviceDetail(String deviceId) async {
    _deviceDetail =
        await DevicesRepository.getThermostatDetails(_request, deviceId);
    notifyListeners();
  }

  Device get deviceDetail => _deviceDetail;

  double get thermostatTargetTemperature =>
      _deviceDetail?.traits?.first?.state?.value ?? 0;
}
