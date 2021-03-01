import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/account_model.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';
import 'package:yonomi_platform_sdk/device.dart';
import 'package:yonomi_platform_sdk/devices.dart';
import 'package:yonomi_platform_sdk/request/request.dart';
import 'package:yonomi_platform_sdk/traits/trait.dart';
import 'package:yonomi_platform_sdk/traits/traitLockUnlock/traitLockUnlockActionQuery.dart';
import 'package:yonomi_platform_sdk/user.dart';

class YoSDKDevicesProvider extends DevicesProvider {
  List<DeviceModel> _devices = [];

  Request request = YoRequestFactory.request();
  Future<void> hydrateDevices() async {
    var devicesFromGraph = (await (Devices.all()..withTraits()).get(request));
    if (devicesFromGraph == null || devicesFromGraph.devices == null) {
      _devices = [];
      notifyListeners();
      return;
    }

    _devices = devicesFromGraph.devices
        .map((device) =>
            DeviceModel(device.id, device.displayName, device.traits))
        .toList();
    notifyListeners();
  }

  Future<void> performAction(Trait trait, String deviceId) async {
    if (trait.name == 'LOCK_UNLOCK') {
      Device device = await Device.findById(deviceId).get(request);
      bool currentDeviceState =
          (trait.state as IsLocked).reportedIsLocked.value;
      await (device
            ..action(
                TraitLockUnlockActionQuery.lockUnlock(!currentDeviceState)))
          .execute(request);
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
  final String _id, _displayName;
  final List<Trait> _traits;

  DeviceModel(this._id, this._displayName, this._traits);

  String get id => _id;

  String get displayName => _displayName;

  List<Trait> get traits => _traits;
}
