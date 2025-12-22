// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleAggregate _$RoleAggregateFromJson(Map<String, dynamic> json) =>
    RoleAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      owner: json['owner'] as bool? ?? false,
      scopeIds: (json['scopeIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toSet(),
    );

Map<String, dynamic> _$RoleAggregateToJson(RoleAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'description': instance.description,
      'owner': instance.owner,
      'scopeIds': instance.scopeIds.toList(),
    };
