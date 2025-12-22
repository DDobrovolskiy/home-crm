// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestAggregate _$TestAggregateFromJson(Map<String, dynamic> json) =>
    TestAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      name: json['name'] as String? ?? 'Новый тест',
      description: json['description'] as String?,
      status: json['status'] == null
          ? StatusDoc.DRAFT
          : const StatusDocConverter().fromJson(json['status'] as String),
      timeLimitMinutes: (json['timeLimitMinutes'] as num?)?.toInt() ?? 0,
      iteration: (json['iteration'] as num?)?.toInt() ?? 0,
      answerCount: (json['answerCount'] as num?)?.toInt() ?? 0,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointed: (json['appointed'] as List<dynamic>?)
          ?.map((e) => AppointedAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestAggregateToJson(TestAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'description': instance.description,
      'status': const StatusDocConverter().toJson(instance.status),
      'timeLimitMinutes': instance.timeLimitMinutes,
      'iteration': instance.iteration,
      'answerCount': instance.answerCount,
      'questions': instance.questions,
      'appointed': instance.appointed,
    };
