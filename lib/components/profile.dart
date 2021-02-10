import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/components/devices.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

class ProfileWidget extends StatelessWidget {
  static String title = "Home";

  Widget build(BuildContext context) {
    final Widget userQuery = getUserQueryWidget();
    final Widget deviceQuery = getDeviceQueryWidget();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: 25),
        userQuery,
        SizedBox(height: 25),
        deviceQuery,
        // Expanded(
        //     child: Container(
        //   width: 100,
        // ))
      ],
    );
  }

  Widget getUserQueryWidget() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.yellow,
            title: Text("Profile",
                style: const TextStyle(
                  color: AppThemes.listViewTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                )),
          ),
          SizedBox(height: 20),
          Text('me.id'),
          Text('me.lastActivityAt'),
          Text('me.firstActivityAt'),
          SizedBox(height: 20) // Text(result.data['me']['firstActivityAt']),
        ],
      ),
    );
  }
}

Widget getDeviceQueryWidget() {
  final DevicesWidget devicesWidget = DevicesWidget();

  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          tileColor: Colors.yellow,
          title: Text("Devices",
              style: const TextStyle(
                color: AppThemes.listViewTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              )),
        ),
        SizedBox(height: 20),
        devicesWidget,
        SizedBox(height: 20)
      ],
    ),
  );
}
