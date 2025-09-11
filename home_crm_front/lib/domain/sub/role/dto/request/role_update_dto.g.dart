// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleUpdateDto _$RoleUpdateDtoFromJson(Map<String, dynamic> json) =>
    RoleUpdateDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      scopes: (json['scopes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RoleUpdateDtoToJson(RoleUpdateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'scopes': instance.scopes,
    };
