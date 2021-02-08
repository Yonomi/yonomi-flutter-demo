import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yonomi_flutter_demo/themes/AppThemes.dart';
import 'package:yonomi_flutter_demo/themes/ColorConstants.dart';

class DeviceItemWidget extends StatelessWidget {
  const DeviceItemWidget(
      {Key key, this.name, this.location, this.state, this.icon})
      : super(key: key);

  final IconData icon;
  final String name;
  final String location;
  final String state;

  @override
  Widget build(BuildContext context) {
    String name = this.name ?? "No name";
    String location = this.location ?? "No location set";
    String state = this.state ?? "Unknown";

    return Container(
        width: 180.0,
        height: 180.0,
        color: ColorConstants.darkestBackground,
        child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        icon,
                        size: 50,
                        color: ColorConstants.deviceIconColor,
                      )),
                  Text(
                    location,
                    style: AppThemes.deviceItemTextLocation,
                  ),
                  Text(
                    name,
                    style: AppThemes.deviceItemTextName,
                  ),
                  Text(
                    state,
                    style: AppThemes.deviceItemTextState,
                  ),
                ])));
  }
}
