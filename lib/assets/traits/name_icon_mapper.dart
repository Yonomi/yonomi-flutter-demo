import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yonomi_platform_sdk/traits/trait.dart';

class DeviceItemIcon {
  static IconData getIcon(List<Trait> traits) {
    if (traits[0].name == 'LOCK_UNLOCK') {
      return ((traits[0].state as IsLocked).reportedIsLocked.value)
          ? Icons.lock
          : Icons.lock_open;
    }
    return Icons.device_unknown;
  }
}
