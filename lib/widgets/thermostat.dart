import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/components/home.dart';
import 'package:yonomi_flutter_demo/components/yonomi_app_bar.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            height: 15,
          ),
        ],
      ),
    );
  }
}
