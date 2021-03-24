import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/providers/thermostat_provider.dart';
import 'package:yonomi_flutter_demo/widgets/components/arc.dart';

import 'components/modes_toolbar.dart';

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
            ModesToolbar(children: [
              ModeButtonWithIcon(
                icon: Text("A"),
                onPressed: () => print("Pressed"),
              ),
              ModeButtonWithIcon(
                icon: Icon(Icons.ac_unit),
                onPressed: () => print("Pressed"),
              ),
              ModeButtonWithIcon(
                icon: Icon(Icons.whatshot),
                onPressed: () => print("Pressed"),
              ),
              ModeButtonWithIcon(
                icon: Icon(Icons.eco),
                onPressed: () => print("Pressed"),
              ),
            ]),
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
              footerWidget: Text('Some value',
                  style: Theme.of(context).textTheme.headline6),
            ))
          ],
        ));
  }
}
