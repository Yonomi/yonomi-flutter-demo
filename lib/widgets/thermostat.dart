import 'package:device_widgets/components/arc.dart';
import 'package:device_widgets/components/device_control.dart';
import 'package:device_widgets/components/modes_toolbar.dart';
import 'package:device_widgets/providers/thermostat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';

class ThermostatWidget extends StatelessWidget {
  final String deviceId;

  const ThermostatWidget({Key key, this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thermostatProvider =
        Provider.of<ThermostatProvider>(context, listen: true);
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: YonomiAppBar(
          'Yonomi Demo App',
          onPressed: () {},
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Text(
                  thermostatProvider?.deviceDetail?.displayName ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ModesToolbar(
                    deviceId: deviceId,
                    thermostatProvider: thermostatProvider)),
            SizedBox(
              height: 60,
            ),
            Center(
                child: Arc(
              centerWidget: Text(
                thermostatProvider.thermostatTargetTemperature
                        ?.toInt()
                        ?.toString() ??
                    '0',
                style: Theme.of(context).textTheme.headline2,
              ),
              initialValue: 20.0,
              onFinalSetPoint: (double temperature) {
                print('Printing temperature');
                // thermostatProvider.setPointAction(deviceId, temperature);
                // data.setPointAction(deviceId, temperature);
              },
              maxValue: 50,
            )),
            SizedBox(
              height: 30,
            ),
            DeviceControl(onOff: true)
          ],
        ));
  }
}
