// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointed_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointedAggregate _$AppointedAggregateFromJson(Map<String, dynamic> json) =>
    AppointedAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      sessions: (json['sessions'] as List<dynamic>?)
          ?.map((e) => SessionAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeeId: (json['employeeId'] as num).toInt(),
      testId: (json['testId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppointedAggregateToJson(AppointedAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'deadline': instance.deadline?.toIso8601String(),
      'sessions': instance.sessions,
      'employeeId': instance.employeeId,
      'testId': instance.testId,
    };
