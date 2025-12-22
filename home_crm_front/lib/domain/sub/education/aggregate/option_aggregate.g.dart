// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionAggregate _$OptionAggregateFromJson(Map<String, dynamic> json) =>
    OptionAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      text: json['text'] as String?,
      correct: json['correct'] as bool? ?? false,
    );

Map<String, dynamic> _$OptionAggregateToJson(OptionAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'text': instance.text,
      'correct': instance.correct,
    };
