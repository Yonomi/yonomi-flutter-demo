import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/thermostat_provider.dart';
import 'package:yonomi_flutter_demo/themes/color_constants.dart';
import 'package:yonomi_flutter_demo/themes/ring_border.dart';
import 'package:yonomi_platform_sdk/graphql/devices/thermostat/thermostat_queries.graphql.dart';

class ModesToolbar extends StatelessWidget {
  String deviceId;

  ThermostatProvider thermostatProvider;

  ModesToolbar({this.deviceId, this.thermostatProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ModeIconButton(
          icon: Text("A"),
          onPressed: () {
            thermostatProvider?.setThermostatMode(
                deviceId, ThermostatMode.auto);
          },
        ),
        ModeIconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () {
            thermostatProvider?.setThermostatMode(
                deviceId, ThermostatMode.cool);
          },
        ),
        ModeIconButton(
          icon: Icon(Icons.whatshot),
          onPressed: () {
            thermostatProvider?.setThermostatMode(
                deviceId, ThermostatMode.heat);
          },
        ),
        ModeIconButton(
          icon: Icon(Icons.eco),
          onPressed: () {
            thermostatProvider?.setThermostatMode(
                deviceId, ThermostatMode.airflow);
          },
        ),
      ],
    );
  }
}

class ModeIconButton extends ElevatedButton {
  ModeIconButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    @required Widget icon,
  })  : assert(icon != null),
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return ColorConstants.modesButtonPressedColor;
                }
                return ColorConstants.modesButtonUnpressedColor;
              },
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return RingBorder(
                  side: BorderSide(
                      color: ColorConstants.modesButtonUnpressedColor,
                      width: 2.0),
                );
              }
              return CircleBorder(side: BorderSide());
            }),
            minimumSize: MaterialStateProperty.all<Size>(Size.square(48.0)),
          ),
          child: ModeButtonIconChild(icon: icon),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding));
  }
}

class ModeButtonIconChild extends StatelessWidget {
  ModeButtonIconChild({Key key, @required this.icon}) : super(key: key);

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon],
    );
  }
}
