// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scope_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScopeDTO _$ScopeDTOFromJson(Map<String, dynamic> json) => ScopeDTO(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ScopeDTOToJson(ScopeDTO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
};
