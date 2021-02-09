import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:yonomi_platform_sdk/devices.dart'


import 'package:yonomi_platform_sdk/request/request.dart';

class DeviceItems extends ChangeNotifier {
  List<DeviceItem> _deviceItems = [];

  Future<List<DeviceItem>> get deviceItems async {
    Request request = Request(
      'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', 
      {'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTI3OTU0NDIsImV4cCI6MTYxMjg4MTg0Mn0.VeOJFzQSRRNApcUWeSlP7YJ27zt4NmAdt1cVD4WBg7OUPh_2vwM-iyYGaCXUkE92Vd7b46Tq42nkChzXqK7RWW_1Y6-VIKyk7JU1qwaal7QQUuyCOoUvY6Muu6B08xNHvOXIO_NSwop-ynL__I18woFYGp8mtaALVAXWGgIeNvCHvvUhAmq27FZ6ahoVZsVT5BaxitbBzExjZliHiq60LEt273WKo1GN76PKyzt6DEw2FcCmg0hpbl-1vk0BDj9MfJ-EYfz018ldizQ-9stwevAmoPv3u4aYK395mw2Yq0MXftxr6J2qlGqk1YsX3xfT_1hAzC4_wxTSvv6oEAk-zw'});
    Devices devices = await Devices.all().get(request);
    return devices.devices.map((device) {
      DeviceItem(device.id, device.displayName, device.description, device.manufacturerName, device.createdAt, device.updatedAt);
    }).toList();
  }
}

class DeviceItem {
  String id;
  String displayName;
  String description;
  String manufacturerName;
  DateTime createdAt;
  DateTime updatedAt;

  DeviceItem(this.id, this.displayName, this.description, this.manufacturerName, this.createdAt,
      this.updatedAt);
}
