import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/assets/traits/device_item_icon.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/login_provider.dart';

class DynamicDevices extends StatelessWidget {
  static final String title = "Home";
  static Widget gridIcon = SvgPicture.asset(
    'assets/icons/grid.svg',
    color: Colors.white,
    semanticsLabel: "grid",
  );

  Widget build(BuildContext context) {
    return Consumer<DevicesProvider>(
      builder: (context, devicesProvider, child) {
        final LoginProvider loginProvider =
            Provider.of<LoginProvider>(context, listen: false);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: gridIcon,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    physics: ClampingScrollPhysics(),
                    children: [
                      ...devicesProvider.devices.map((device) {
                        String mainTraitName = (device.traits.isEmpty)
                            ? 'None'
                            : device.traits.first.name;
                        return DeviceItemWidget(
                          deviceIcon: DeviceItemIcon.getIcon(device.traits),
                          location: 'Main Trait: ${mainTraitName}',
                          name: device.displayName,
                          onPressed: () {
                            Navigator.pushNamed(context, 'traitDetailPage',
                                arguments: [
                                  device.id,
                                  loginProvider.request,
                                  device.displayName
                                ]);
                          },
                          state: 'Trait Count: ${device.traits.length}',
                        );
                      }).toList()
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
