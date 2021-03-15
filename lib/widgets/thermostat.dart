import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';
import 'package:yonomi_flutter_demo/themes/color_constants.dart';

import 'components/slider_component.dart';

class ThermostatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'Thermostat',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Center(
            child: SliderComponent(
              mode: SliderMode.singleSelection,
              width: 200,
              height: 200,
              arcColor: ColorConstants.yonomiYellow,
            ),
          )
        ],
      ),
    );
  }
}
