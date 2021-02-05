import 'package:flutter/widgets.dart';

class DeviceItemWidget extends StatefulWidget {
  String _deviceName;

  String _deviceLocation;

  String _deviceState;

  DeviceItemWidget(
      {String name, String location, String state, IconData icon}) {
    this._deviceName = name ?? "No name";
    this._deviceLocation = location ?? "No location set";
    this._deviceState = state ?? "Unknown";
  }

  @override
  State<StatefulWidget> createState() => DeviceItemWidgetState();
}

class DeviceItemWidgetState extends State<DeviceItemWidget> {
  @override
  Widget build(BuildContext context) {
    String location = widget._deviceLocation ?? "";
    String name = widget._deviceName ?? "";
    String state = widget._deviceState ?? "";

    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
  }
}
