import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/providers/thermostat_provider.dart';
import 'package:yonomi_flutter_demo/themes/color_constants.dart';

import 'components/slider_component.dart';

class ThermostatWidget extends StatelessWidget {
  final String deviceId;

  const ThermostatWidget({Key key, this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: YonomiAppBar(
        'Yonomi Demo App',
        onPressed: () {},
      ),
      body: Consumer<ThermostatProvider>(
        builder: (context, data, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Text(
                    'Thermostat',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: SliderComponent(
                  mode: SliderMode.singleSelection,
                  width: 300,
                  height: 300,
                  minimumRange: 0.0,
                  maximumRange: 100.0,
                  onValueChanged: (double temperature) {
                    data.setPointAction(deviceId, temperature);
                  },
                  currentValue: data?.getThermostatSetPoint(),
                  arcColorStart: ColorConstants.yonomiYellow,
                  centerWidget: Text(
                    data?.getThermostatSetPoint().toString(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
