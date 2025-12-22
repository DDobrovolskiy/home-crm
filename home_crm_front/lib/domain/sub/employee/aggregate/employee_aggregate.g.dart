// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeAggregate _$EmployeeAggregateFromJson(Map<String, dynamic> json) =>
    EmployeeAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      user: UserAggregate.fromJson(json['user'] as Map<String, dynamic>),
      roleId: (json['roleId'] as num).toInt(),
    );

Map<String, dynamic> _$EmployeeAggregateToJson(EmployeeAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'user': instance.user,
      'roleId': instance.roleId,
    };
