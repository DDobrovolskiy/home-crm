import 'package:home_crm_front/domain/sub/education/session/dto/response/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_sessions_dto.g.dart';

@JsonSerializable()
class EmployeeSessionsDto {
  final List<SessionDto> sessions;

  EmployeeSessionsDto({required this.sessions});

  Map<String, dynamic> toJson() {
    return _$EmployeeSessionsDtoToJson(this);
  }

  factory EmployeeSessionsDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSessionsDtoFromJson(json);
}
