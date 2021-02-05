import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/models/device_item_model.dart';

class DeviceItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<DeviceItemModel>(
        builder: (context, deviceItemModel, child) {
          String location = deviceItemModel.deviceLocation ?? "";
          String name = deviceItemModel.deviceName ?? "";
          String state = deviceItemModel.deviceState ?? "";

          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  location,
                  key: Key("deviceLocation"),
                ),
                Text(
                  name,
                  key: Key("deviceName"),
                ),
                Text(
                  state,
                  key: Key("deviceState"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
