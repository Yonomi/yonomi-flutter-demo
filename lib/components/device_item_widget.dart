import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class DeviceItemWidget extends StatelessWidget {
  const DeviceItemWidget(
      {Key key,
      this.name,
      this.location,
      this.state,
      this.deviceIcon,
      this.onPressed})
      : super(key: key);

  final Widget deviceIcon;
  final String name;
  final String location;
  final String state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String name = this.name ?? "No name";
    String location = this.location ?? "No location set";
    String state = this.state ?? "Unknown";

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 175, height: 175),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                AppThemes.deviceItemBackgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ))),
        // Simplify the attributes below
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: 60, height: 60, child: deviceIcon),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      location,
                      style: AppThemes.deviceItemTextLocation,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Text(
                        name,
                        style: AppThemes.deviceItemTextName,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      state,
                      style: AppThemes.deviceItemTextState,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
