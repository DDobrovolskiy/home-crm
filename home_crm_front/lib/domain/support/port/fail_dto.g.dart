// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fail _$FailFromJson(Map<String, dynamic> json) =>
    Fail(event: json['event'] as String, message: json['message'] as String);

Map<String, dynamic> _$FailToJson(Fail instance) => <String, dynamic>{
  'event': instance.event,
  'message': instance.message,
};
