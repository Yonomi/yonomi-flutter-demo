import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key key, this.title, this.defaultUrl})
      : super(key: key);

  final String title;

  final String defaultUrl;

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            //widget.onCancel();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            //widget.onOk();
          },
        ),
      ],
      content: Table(
        children: [
          TableRow(children: [
            TableCell(child: Text("Access Token")),
            TableCell(child: TextField()),
          ]),
          TableRow(children: [
            TableCell(child: Text("Endpoint")),
            TableCell(child: TextField()),
          ]),
        ],
      ),
    );
  }
}
