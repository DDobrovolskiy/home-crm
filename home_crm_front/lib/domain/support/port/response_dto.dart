import 'package:home_crm_front/domain/support/port/base_dto.dart';
import 'package:home_crm_front/domain/support/port/error_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseDTO<T> extends BaseDTO {
  final T? data;

  ResponseDTO({
    required this.data,
    required super.status,
    required super.errorData,
  });

  Map<String, dynamic> toJsonRequest(Object? Function(T value) toJsonT) {
    return _$ResponseDTOToJson(this, toJsonT);
  }

  factory ResponseDTO.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ResponseDTOFromJson(json, fromJsonT);
}
