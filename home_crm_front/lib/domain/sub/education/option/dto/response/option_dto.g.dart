// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionDto _$OptionDtoFromJson(Map<String, dynamic> json) => OptionDto(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  correct: json['correct'] as bool,
);

Map<String, dynamic> _$OptionDtoToJson(OptionDto instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'correct': instance.correct,
};
