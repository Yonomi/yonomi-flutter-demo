import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';

class DeviceItemIcon {
  static IconData getIcon(List<Trait> traits) {
    if (traits[0] is LockUnlockTrait) {
      return (traits[0].state.value) ? Icons.lock : Icons.lock_open;
    }
    if (traits[0] is ThermostatTrait) {
      return Icons.thermostat_outlined;
    }
    return Icons.device_unknown;
  }
}
