// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDTO<T> _$ResponseDTOFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ResponseDTO<T>(
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  status: (json['status'] as num?)?.toInt(),
  errorData: json['errorData'] == null
      ? null
      : ErrorDate.fromJson(json['errorData'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResponseDTOToJson<T>(
  ResponseDTO<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'status': instance.status,
  'errorData': instance.errorData,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
