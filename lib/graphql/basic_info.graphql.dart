// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'basic_info.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class BasicInfo$Query$User with EquatableMixin {
  BasicInfo$Query$User();

  factory BasicInfo$Query$User.fromJson(Map<String, dynamic> json) =>
      _$BasicInfo$Query$UserFromJson(json);

  String id;

  @override
  List<Object> get props => [id];
  Map<String, dynamic> toJson() => _$BasicInfo$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BasicInfo$Query$Tenant with EquatableMixin {
  BasicInfo$Query$Tenant();

  factory BasicInfo$Query$Tenant.fromJson(Map<String, dynamic> json) =>
      _$BasicInfo$Query$TenantFromJson(json);

  String id;

  String displayName;

  @override
  List<Object> get props => [id, displayName];
  Map<String, dynamic> toJson() => _$BasicInfo$Query$TenantToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BasicInfo$Query with EquatableMixin {
  BasicInfo$Query();

  factory BasicInfo$Query.fromJson(Map<String, dynamic> json) =>
      _$BasicInfo$QueryFromJson(json);

  BasicInfo$Query$User me;

  BasicInfo$Query$Tenant tenant;

  @override
  List<Object> get props => [me, tenant];
  Map<String, dynamic> toJson() => _$BasicInfo$QueryToJson(this);
}

class BasicInfoQuery extends GraphQLQuery<BasicInfo$Query, JsonSerializable> {
  BasicInfoQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'basicInfo'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'me'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ])),
          FieldNode(
              name: NameNode(value: 'tenant'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'displayName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'basicInfo';

  @override
  List<Object> get props => [document, operationName];
  @override
  BasicInfo$Query parse(Map<String, dynamic> json) =>
      BasicInfo$Query.fromJson(json);
}
