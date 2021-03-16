import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/providers/thermostat_provider.dart';
import 'package:yonomi_flutter_demo/themes/color_constants.dart';
import 'package:yonomi_flutter_demo/widgets/components/arc.dart';

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
                  // child: SliderComponent(
                  //   mode: SliderMode.singleSelection,
                  //   width: 300,
                  //   height: 300,
                  //   minimumRange: 0.0,
                  //   maximumRange: 100.0,
                  //   onValueChanged: (double temperature) {
                  //     data.setPointAction(deviceId, temperature);
                  //   },
                  //   currentValue:
                  //       data?.deviceDetail?.traits?.first?.state?.value ?? 0,
                  //   arcColorStart: ColorConstants.yonomiYellow,
                  //   centerWidget: Text(
                  //     data?.deviceDetail?.traits?.first?.state?.value
                  //             ?.toString() ??
                  //         '0',
                  //     style: Theme.of(context).textTheme.headline2,
                  //   ),
                  // ),
                  child: Arc(
                      centerWidget: Text(
                        data?.deviceDetail?.traits?.first?.state?.value
                                ?.toInt()
                                ?.toString() ??
                            '0',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      initialValue:
                          data?.deviceDetail?.traits?.first?.state?.value ??
                              0.0,
                      onFinalSetPoint: (double temperature) {
                        print('Printing temperature');
                        print(temperature);
                        // data.setPointAction(deviceId, temperature);
                      },
                      maxValue: 50))
            ],
          );
        },
      ),
    );
  }
}
