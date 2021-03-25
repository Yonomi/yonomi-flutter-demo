import 'package:flutter/material.dart';

class DeviceControl extends StatelessWidget {
  final bool onOff;
  const DeviceControl({
    Key key,
    @required this.onOff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Row(
          children: [
            Text(
              'Fan',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.black),
            ),
            Chip(label: (onOff) ? Text('On') : Text('Off'))
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
        ));
  }
}
