// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  test: TestDto.fromJson(json['test'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'test': instance.test,
    };
