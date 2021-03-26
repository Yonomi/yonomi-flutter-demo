import 'package:flutter/material.dart';

class DeviceControl extends StatelessWidget {
  final bool onOff;
  const DeviceControl({
    Key key,
    @required this.onOff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.teal[200], width: 3)),
      child: ListTile(
          dense: false,
          leading: Row(
            children: [
              Text(
                'Fan',
                textScaleFactor: 2,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Chip(
                  label: (onOff)
                      ? Text(
                          'On',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      : Text('Off'))
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          trailing: Row(
            children: [
              Switch(
                value: onOff,
                onChanged: (bool value) => print(value),
              ),
              GestureDetector(child: Icon(Icons.more_vert))
            ],
            mainAxisSize: MainAxisSize.min,
          )),
    );
  }
}
