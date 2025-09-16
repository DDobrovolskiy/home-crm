import 'package:json_annotation/json_annotation.dart';

part 'session_get_or_create_dto.g.dart';

@JsonSerializable()
class SessionGetOrCreateDto {
  final int testId;
  final int employeeId;

  SessionGetOrCreateDto({required this.testId, required this.employeeId});

  Map<String, dynamic> toJson() {
    return _$SessionGetOrCreateDtoToJson(this);
  }

  factory SessionGetOrCreateDto.fromJson(Map<String, dynamic> json) =>
      _$SessionGetOrCreateDtoFromJson(json);
}
