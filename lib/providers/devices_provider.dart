import 'package:flutter/material.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

typedef GetDevicesFunction = Future<List<Device>> Function(Request request);

typedef GetDeviceDetailsFunction = Future<Device> Function(
    Request request, String id);

typedef SendLockUnlockFunction = Future<void> Function(
    Request request, String id, bool lockUnlock);

class DevicesProvider extends ChangeNotifier {
  List<DeviceModel> _devices = [];

  final Request request;

  DevicesProvider(this.request, {GetDevicesFunction? injectGetDevicesMethod}) {
    this.hydrateDevices(injectGetDevicesMethod: injectGetDevicesMethod);
  }

  Future<void> hydrateDevices(
      {GetDevicesFunction? injectGetDevicesMethod}) async {
    final getDevicesMethod =
        injectGetDevicesMethod ?? DevicesRepository.getDevices;
    var devicesFromGraph = await getDevicesMethod(request);
    _devices = devicesFromGraph
        .map((device) => DeviceModel(
            device.id, device.displayName, device.traits, device.description))
        .toList();

    notifyListeners();
  }

  Future<void> performAction(Trait trait, String deviceId,
      {GetDeviceDetailsFunction? injectGetDeviceDetailsMethod,
      SendLockUnlockFunction? injectSendLockUnlockMethod}) async {
    final getDeviceDetailsMethod =
        injectGetDeviceDetailsMethod ?? DevicesRepository.getDeviceDetails;

    final sendLockUnlockMethod =
        injectSendLockUnlockMethod ?? LockRepository.sendLockUnlockAction;

    if (trait.runtimeType == LockTrait) {
      Device device = await getDeviceDetailsMethod(request, deviceId);
      sendLockUnlockMethod(
          request, deviceId, !device.traits[0].states.first.value);
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
