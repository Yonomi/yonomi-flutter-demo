import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/assets/traits/name_icon_mapper.dart';
import 'package:yonomi_flutter_demo/components/device_item_widget.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatelessWidget {
  static final String title = "Home";
  static Widget gridIcon = SvgPicture.asset(
    'assets/icons/grid.svg',
    color: Colors.white,
    semanticsLabel: "grid",
  );

  Widget build(BuildContext context) {
    return Consumer<DevicesProvider>(
      builder: (context, data, child) {
        data.hydrateDevices();
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
                    // padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    physics: ClampingScrollPhysics(),
                    children: [
                      ...data?.devices?.map((device) {
                        return DeviceItemWidget(
                            icon: DeviceItemIcon.getIcon(device.traits),
                            location: 'entryway',
                            name: device.displayName,
                            onPressed: () {
                              data.performAction(device.traits[0], device.id);
                            });
                      })?.toList()
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
