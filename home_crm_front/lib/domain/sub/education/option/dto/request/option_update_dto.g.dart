// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionUpdateDto _$OptionUpdateDtoFromJson(Map<String, dynamic> json) =>
    OptionUpdateDto(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      correct: json['correct'] as bool,
    );

Map<String, dynamic> _$OptionUpdateDtoToJson(OptionUpdateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'correct': instance.correct,
    };
