import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_platform_sdk/traits/trait.dart';
import 'package:yonomi_platform_sdk/request/request.dart';

class TestDeviceProvider extends ChangeNotifier implements DevicesProvider {
  @override
  // TODO: implement devices
  List<DeviceModel> get devices => throw UnimplementedError();

  @override
  Future<void> fetchDevices() {
    // TODO: implement fetchDevices
    throw UnimplementedError();
  }

  @override
  Future<void> performAction(Trait trait, String deviceId) {
    // TODO: implement performAction
    throw UnimplementedError();
  }
}

Widget createDeviceItemWidget(
    {String state,
    String name,
    String location,
    IconData iconData,
    VoidCallback onPressed}) {
  return MaterialApp(
    home: DeviceItemWidget(
      icon: iconData,
      state: state,
      name: name,
      location: location,
      onPressed: onPressed,
    ),
  );
}
