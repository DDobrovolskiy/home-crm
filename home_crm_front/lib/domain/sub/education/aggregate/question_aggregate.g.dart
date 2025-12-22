// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAggregate _$QuestionAggregateFromJson(Map<String, dynamic> json) =>
    QuestionAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      text: json['text'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionAggregateToJson(QuestionAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'text': instance.text,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };
