import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';
import 'package:yonomi_platform_sdk/repository/devices/lock_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class YoSDKDevicesProvider extends DevicesProvider {
  List<DeviceModel> _devices = [];

  String _userId;
  Future<Request> _request;

  YoSDKDevicesProvider(String userId) {
    _userId = userId;
    _request = YoRequest.request(_userId);
  }

  Future<void> hydrateDevices() async {
    final request = await _request;
    var devicesFromGraph = (await (DevicesRepository.getDevices(request)));
    if (devicesFromGraph == null) {
      _devices = [];
      notifyListeners();
      return;
    }

    _devices = devicesFromGraph
        .map((device) => DeviceModel(
            device.id, device.displayName, device.traits, device.description))
        .toList();
    notifyListeners();
  }

  Future<void> performAction(Trait trait, String deviceId) async {
    final request = await _request;
    if (trait.name == 'lockUnlock') {
      Device device =
          await DevicesRepository.getDeviceDetails(request, deviceId);

      await LockRepository.sendLockUnlockAction(
          request, deviceId, !device.traits[0].state.value);
    }
  }

  List<DeviceModel> get devices => _devices;
}

abstract class DevicesProvider extends ChangeNotifier {
  Future<void> hydrateDevices();
  Future<void> performAction(Trait trait, String deviceId);
  List<DeviceModel> get devices;
}

class DeviceModel {
  final String _id, _displayName, _description;
  final List<Trait> _traits;

  DeviceModel(this._id, this._displayName, this._traits, this._description);

  String get id => _id;

  String get displayName => _displayName;

  String get description => _description;

  List<Trait> get traits => _traits;
}
