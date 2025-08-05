import 'package:home_crm_front/domain/support/port/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../support/port/error_data_dto.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto extends BaseDTO {
  final String? data;

  AuthResponseDto({
    required super.status,
    required super.errorData,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return _$AuthResponseDtoToJson(this);
  }

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}
