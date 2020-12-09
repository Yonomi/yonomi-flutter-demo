// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicInfo$Query$User _$BasicInfo$Query$UserFromJson(Map<String, dynamic> json) {
  return BasicInfo$Query$User()
    ..id = json['id'] as String
    ..firstActivityAt = json['firstActivityAt'] == null
        ? null
        : DateTime.parse(json['firstActivityAt'] as String)
    ..lastActivityAt = json['lastActivityAt'] == null
        ? null
        : DateTime.parse(json['lastActivityAt'] as String);
}

Map<String, dynamic> _$BasicInfo$Query$UserToJson(
        BasicInfo$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstActivityAt': instance.firstActivityAt?.toIso8601String(),
      'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
    };

BasicInfo$Query$Tenant _$BasicInfo$Query$TenantFromJson(
    Map<String, dynamic> json) {
  return BasicInfo$Query$Tenant()
    ..id = json['id'] as String
    ..displayName = json['displayName'] as String;
}

Map<String, dynamic> _$BasicInfo$Query$TenantToJson(
        BasicInfo$Query$Tenant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
    };

BasicInfo$Query _$BasicInfo$QueryFromJson(Map<String, dynamic> json) {
  return BasicInfo$Query()
    ..me = json['me'] == null
        ? null
        : BasicInfo$Query$User.fromJson(json['me'] as Map<String, dynamic>)
    ..tenant = json['tenant'] == null
        ? null
        : BasicInfo$Query$Tenant.fromJson(
            json['tenant'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BasicInfo$QueryToJson(BasicInfo$Query instance) =>
    <String, dynamic>{
      'me': instance.me?.toJson(),
      'tenant': instance.tenant?.toJson(),
    };
