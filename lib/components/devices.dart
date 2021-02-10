import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/models/deviceModel.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';

class DevicesWidget extends StatelessWidget {
  static final String title = "Devices";

  Widget build(BuildContext context) {
    List<DeviceModel> devices = [DeviceModel('deviceId')];
    return ListView(
      children: devices.map((device) {
        final innerText = (device.id);
        return Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppThemes.listViewBackgroundColor),
            child: Center(
              child: Column(
                children: [
                  Text(
                    innerText,
                    style: TextStyle(color: AppThemes.listViewTextColor),
                  ),
                  // Text('TRAITS:'),
                  Text(
                    'TRAITS:',
                    style: TextStyle(color: AppThemes.listViewTextColor),
                  )
                ],
              ),
            ));
      }).toList(),
      // children: [Text(edges[0]['node']['createdAt'].toString())],
      shrinkWrap: true,
    );
  }
}
