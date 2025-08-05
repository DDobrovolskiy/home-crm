import 'package:json_annotation/json_annotation.dart';

part 'error_data_dto.g.dart';

@JsonSerializable()
class ErrorDate {
  final String? message;

  ErrorDate({required this.message});

  Map<String, dynamic> toJson() {
    return _$ErrorDateToJson(this);
  }

  factory ErrorDate.fromJson(Map<String, dynamic> json) =>
      _$ErrorDateFromJson(json);
}
