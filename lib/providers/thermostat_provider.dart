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
    _request = YoRequest.request(_userId);
  }

  String _userId;
  Device _deviceDetail;
  Future<Request> _request;

  Future<void> setPointAction(String deviceId, double temperature) async {
    final request = await _request;
    ThermostatRepository.setPointThermostat(request, deviceId, temperature);
  }

  Future<void> setThermostatMode(String deviceId, ThermostatMode mode) async {
    final request = await _request;
    ThermostatRepository.setMode(request, deviceId, mode);
  }

  Future<void> getDeviceDetail(String deviceId) async {
    final request = await _request;
    _deviceDetail =
        await DevicesRepository.getThermostatDetails(request, deviceId);
    notifyListeners();
  }

  Device get deviceDetail => _deviceDetail;

  double get thermostatTargetTemperature =>
      _deviceDetail?.traits?.first?.state?.value ?? 0;
}
