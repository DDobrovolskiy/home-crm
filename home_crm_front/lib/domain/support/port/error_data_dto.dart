import 'package:home_crm_front/domain/support/port/fail_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_data_dto.g.dart';

@JsonSerializable()
class ErrorDate {
  final List<Fail>? errors;

  ErrorDate({required this.errors});

  Map<String, dynamic> toJson() {
    return _$ErrorDateToJson(this);
  }

  factory ErrorDate.fromJson(Map<String, dynamic> json) =>
      _$ErrorDateFromJson(json);
}
