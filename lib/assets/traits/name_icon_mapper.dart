import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yonomi_flutter_demo/themes/color_constants.dart';
import 'package:yonomi_platform_sdk/repository/devices/devices_repository.dart';

class DeviceItemIcon {
  static Widget getIcon(List<Trait> traits) {
    Trait determiningTrait = traits[0];
    if (determiningTrait is LockUnlockTrait) {
      return (traits[0].state.value)
          ? Icon(
              Icons.lock,
              size: 60,
              color: ColorConstants.deviceIconColor,
            )
          : Icon(
              Icons.lock_open,
              size: 60,
              color: ColorConstants.deviceIconColor,
            );
    }
    if (determiningTrait is ThermostatTrait) {
      return Icon(
        Icons.thermostat_outlined,
        size: 60,
        color: ColorConstants.deviceIconColor,
      );
    }
    return Icon(
      Icons.device_unknown,
      size: 60,
      color: ColorConstants.deviceIconColor,
    );
  }
}
