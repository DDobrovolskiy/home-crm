import 'package:home_crm_front/domain/support/port/error_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_dto.g.dart';

@JsonSerializable()
class BaseDTO {
  final int status;
  final ErrorDate? errorData;

  BaseDTO({required this.status, required this.errorData});

  Map<String, dynamic> toJson() {
    return _$BaseDTOToJson(this);
  }

  factory BaseDTO.fromJson(Map<String, dynamic> json) =>
      _$BaseDTOFromJson(json);

  String? fullErrorMessage() {
    return errorData?.errors?.map((e) => e.message).join('\n');
  }
}
