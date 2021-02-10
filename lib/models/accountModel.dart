import 'package:flutter/material.dart';

class AccountModel extends ChangeNotifier {
  final String _displayName;

  AccountModel(this._displayName);

  String get displayName => this._displayName;
}
