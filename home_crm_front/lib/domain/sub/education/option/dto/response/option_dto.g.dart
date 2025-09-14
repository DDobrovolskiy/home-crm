// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionDto _$OptionDtoFromJson(Map<String, dynamic> json) => OptionDto(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  correct: json['correct'] as bool,
  question: QuestionDto.fromJson(json['question'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OptionDtoToJson(OptionDto instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'correct': instance.correct,
  'question': instance.question,
};
