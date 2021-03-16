import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/repository/devices_repository.dart';

class ThermostatProvider extends ChangeNotifier {
  ThermostatProvider(String deviceId) {
    getDeviceDetail(deviceId);
  }

  final request = YoRequestCreator.request();
  Device _deviceDetail;

  Future<void> setPointAction(String deviceId, double temperature) async {
    print('temperature');
    print(temperature);
    DevicesRepository.setPointThermostat(request, deviceId, temperature);
  }

  Future<Device> getDeviceDetail(String deviceId) async {
    _deviceDetail =
        await DevicesRepository.getThermostatDetails(request, deviceId);
    print('Reached deviceDetails');
    notifyListeners();
  }

  double getThermostatSetPoint() {
    return _deviceDetail?.traits?.first?.state?.value ?? 0;
  }

  Device get deviceDetail => _deviceDetail;
}
