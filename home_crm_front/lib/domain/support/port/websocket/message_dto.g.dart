// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
  name: json['name'] as String,
  ids: (json['ids'] as List<dynamic>).map((e) => (e as num).toInt()).toSet(),
);

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{'name': instance.name, 'ids': instance.ids.map((e) => (e as num).toInt()).toList()};
