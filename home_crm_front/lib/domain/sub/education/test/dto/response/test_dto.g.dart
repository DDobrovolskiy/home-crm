// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestDto _$TestDtoFromJson(Map<String, dynamic> json) => TestDto(
  (json['id'] as num).toInt(),
  json['number'] as String,
  json['name'] as String,
  json['description'] as String,
  StatusDoc.fromJson(json['status'] as String),
  (json['timeLimitMinutes'] as num).toInt(),
  (json['iteration'] as num).toInt(),
  (json['questions'] as List<dynamic>)
      .map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['employees'] as List<dynamic>)
      .map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TestDtoToJson(TestDto instance) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'name': instance.name,
  'description': instance.description,
  'status': instance.status,
  'timeLimitMinutes': instance.timeLimitMinutes,
  'iteration': instance.iteration,
  'questions': instance.questions,
  'employees': instance.employees,
};
