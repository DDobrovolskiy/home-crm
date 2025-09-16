import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/response/employee_tests_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_tests_view_dto.g.dart';

@JsonSerializable()
class EmployeeTestsViewDto {
  final EmployeeDto employee;
  final EmployeeTestsDto employeeTests;

  EmployeeTestsViewDto({required this.employee, required this.employeeTests});

  Map<String, dynamic> toJson() {
    return _$EmployeeTestsViewDtoToJson(this);
  }

  factory EmployeeTestsViewDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTestsViewDtoFromJson(json);
}
