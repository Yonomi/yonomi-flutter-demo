class UserModel {
  final String _id;
  final DateTime _lastActivityAt, _firstActivityAt;

  UserModel(this._id, this._firstActivityAt, this._lastActivityAt);

  String get displayName => this._id;
  DateTime get firstActivityAt => this._firstActivityAt;
  DateTime get lastActivityAt => this._lastActivityAt;
}
