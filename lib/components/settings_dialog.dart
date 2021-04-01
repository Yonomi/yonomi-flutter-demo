import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/request.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key key, this.title, this.defaultUrl, this.accessToken})
      : super(key: key);

  final String title;

  final String accessToken;

  final String defaultUrl;

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  TextEditingController _accessTokenController;
  TextEditingController _endpointUrlController;

  @override
  void initState() {
    super.initState();
    _accessTokenController = TextEditingController(text: widget.accessToken)
      ..addListener(() {
        setState(() {});
      });
    _endpointUrlController = TextEditingController(text: widget.defaultUrl)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _accessTokenController.dispose();
    _endpointUrlController.dispose();
    super.dispose();
  }

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
            Navigator.pushReplacementNamed(context, "/");
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            showSavedData(context, _accessTokenController.text,
                _endpointUrlController.text);
          },
        ),
      ],
      content: Table(
        children: [
          TableRow(children: [
            TableCell(child: Text("Access Token")),
            TableCell(
              child: TextField(
                controller: _accessTokenController,
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(child: Text("Endpoint")),
            TableCell(
              child: TextField(
                controller: _endpointUrlController,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  void showSavedData(
      BuildContext context, String accessToken, String endpointUrl) {
    YoRequestCreator.token = accessToken;
    YoRequestCreator.endpoint = endpointUrl;
    // print("Access token is now: ${_accessTokenController.text}");
    // print("Endpoint URL is now: ${_endpointUrlController.text}");

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Saved"),
    ));
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.pushReplacementNamed(context, "/");
    });
  }
}
