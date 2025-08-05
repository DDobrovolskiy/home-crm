// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDTO _$BaseDTOFromJson(Map<String, dynamic> json) => BaseDTO(
  status: (json['status'] as num).toInt(),
  errorData: json['errorData'] == null
      ? null
      : ErrorDate.fromJson(json['errorData'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BaseDTOToJson(BaseDTO instance) => <String, dynamic>{
  'status': instance.status,
  'errorData': instance.errorData,
};
