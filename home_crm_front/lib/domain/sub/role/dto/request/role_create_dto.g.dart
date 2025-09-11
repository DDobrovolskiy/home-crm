// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleCreateDto _$RoleCreateDtoFromJson(Map<String, dynamic> json) =>
    RoleCreateDto(
      name: json['name'] as String,
      description: json['description'] as String,
      scopes: (json['scopes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RoleCreateDtoToJson(RoleCreateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'scopes': instance.scopes,
    };
