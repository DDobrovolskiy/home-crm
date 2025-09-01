import 'package:home_crm_front/domain/sub/employee/dto/employee_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_employee_dto.g.dart';

@JsonSerializable()
class OrganizationEmployeeDto {
  final List<EmployeeDto> employees;

  OrganizationEmployeeDto({required this.employees});

  Map<String, dynamic> toJson() {
    return _$OrganizationEmployeeDtoToJson(this);
  }

  factory OrganizationEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationEmployeeDtoFromJson(json);
}
