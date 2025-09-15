// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionCreateDto _$OptionCreateDtoFromJson(Map<String, dynamic> json) =>
    OptionCreateDto(
      correct: json['correct'] as bool,
      text: json['text'] as String,
      questionId: (json['questionId'] as num).toInt(),
    );

Map<String, dynamic> _$OptionCreateDtoToJson(OptionCreateDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'correct': instance.correct,
      'questionId': instance.questionId,
    };
