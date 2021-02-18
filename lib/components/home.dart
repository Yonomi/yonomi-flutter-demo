import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/assets/traits/name_icon_mapper.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';

class HomeWidget extends StatelessWidget {
  static final String title = "Home";

  Widget build(BuildContext context) {
    // DevicesProvider devicesProvier = Provider.of<DevicesProvider>(context);
    // devicesProvier.fetchDevices();
    return Consumer<DevicesProvider>(
      builder: (context, data, child) {
        return Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            physics: ClampingScrollPhysics(),
            children: data?.devices?.map((device) {
              return DeviceItemWidget(
                icon: DeviceItemIcon.getIcon(device.traits),
                location: 'entryway',
                name: device.displayName,
                onPressed: () =>
                    data.performAction(device.traits[0], device.id),
              );
            })?.toList(),
          ),
        );
      },
    );
  }
}
