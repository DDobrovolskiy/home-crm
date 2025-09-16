import 'package:home_crm_front/domain/sub/education/test/dto/response/test_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  final int id;
  final String startTime;
  final String endTime;
  final EmployeeDto employee;
  final TestDto test;
  final bool active;

  SessionDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.employee,
    required this.test,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return _$SessionDtoToJson(this);
  }

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);
}
