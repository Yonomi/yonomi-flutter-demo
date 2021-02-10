import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';
import 'package:yonomi_flutter_demo/themes/ColorConstants.dart';

class DeviceItemWidget extends StatelessWidget {
  const DeviceItemWidget(
      {Key key,
      this.name,
      this.location,
      this.state,
      this.icon,
      this.onPressed})
      : super(key: key);

  final IconData icon;
  final String name;
  final String location;
  final String state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String name = this.name ?? "No name";
    String location = this.location ?? "No location set";
    String state = this.state ?? "Unknown";

    return Container(
        width: 175.0,
        height: 175.0,
        child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              color: AppThemes.deviceItemBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  size: 60,
                  color: ColorConstants.deviceIconColor,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        location,
                        style: AppThemes.deviceItemTextLocation,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Text(
                          name,
                          style: AppThemes.deviceItemTextName,
                        ),
                      ),
                      Text(
                        state,
                        style: AppThemes.deviceItemTextState,
                      ),
                    ]),
              ],
            )));
  }
}
