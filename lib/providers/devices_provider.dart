import 'package:flutter/material.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';
import 'package:yonomi_platform_sdk/repository/devices/lock_repository.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class DevicesProvider extends ChangeNotifier {
  List<DeviceModel> _devices = [];
  final Request request;
  DevicesProvider(this.request);

  Future<void> hydrateDevices() async {
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
    if (trait.name == 'lockUnlock') {
      Device device =
          await DevicesRepository.getDeviceDetails(request, deviceId);

      await LockRepository.sendLockUnlockAction(
          request, deviceId, !device.traits[0].state.value);
    }
  }

  List<DeviceModel> get devices => _devices;
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
