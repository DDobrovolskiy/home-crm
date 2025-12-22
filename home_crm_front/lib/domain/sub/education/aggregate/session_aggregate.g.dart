// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionAggregate _$SessionAggregateFromJson(Map<String, dynamic> json) =>
    SessionAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      dateStart: DateTime.parse(json['dateStart'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      success: json['success'] as bool,
      answers: (json['answers'] as num).toInt(),
    );

Map<String, dynamic> _$SessionAggregateToJson(SessionAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'dateStart': instance.dateStart.toIso8601String(),
      'dateEnd': instance.dateEnd.toIso8601String(),
      'success': instance.success,
      'answers': instance.answers,
    };
