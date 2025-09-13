import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_employees_dto.g.dart';

@JsonSerializable()
class RoleEmployeeDto {
  final List<EmployeeDto> employees;

  RoleEmployeeDto({required this.employees});

  Map<String, dynamic> toJson() {
    return _$RoleEmployeeDtoToJson(this);
  }

  factory RoleEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$RoleEmployeeDtoFromJson(json);
}
