import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/assets/traits/device_item_icon.dart';
import 'package:yonomi_device_widgets/devices/thermostat.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/providers/login_provider.dart';
import 'package:yonomi_flutter_demo/themes/string_constants.dart';

class HomeWidget extends StatelessWidget {
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
                    Text(
                      'Devices',
                      style: Theme.of(context).textTheme.headline6,
                    ),
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
                        if (device.description
                            .toLowerCase()
                            .contains('thermostat')) {
                          return DeviceItemWidget(
                            deviceIcon: DeviceItemIcon.getIcon(device.traits),
                            location: 'home',
                            name: device.displayName,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Scaffold(
                                    extendBodyBehindAppBar: false,
                                    appBar: YonomiAppBar(
                                      StringConstants.default_app_bar_title,
                                      onPressed: () {},
                                    ),
                                    body: Thermostat(
                                        deviceId: device.id,
                                        request: loginProvider.request),
                                  );
                                }),
                              );
                            },
                          );
                        }
                        if (device.description.toLowerCase().contains('lock')) {
                          return DeviceItemWidget(
                            deviceIcon: DeviceItemIcon.getIcon(device.traits),
                            location: 'home',
                            name: device.displayName,
                            onPressed: () {
                              devicesProvider.performAction(
                                  device.traits[0], device.id);
                            },
                            onLongPressed: () {
                              Navigator.pushNamed(context, 'lockDetailPage',
                                  arguments: [
                                    device.id,
                                    loginProvider.request
                                  ]);
                            },
                          );
                        }
                        return SizedBox.shrink();
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
