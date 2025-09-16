import 'package:home_crm_front/domain/sub/employee/dto/response/employee_tests_view_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_employee_test_dto.g.dart';

@JsonSerializable()
class OrganizationEmployeeTestDto {
  final List<EmployeeTestsViewDto> employees;

  OrganizationEmployeeTestDto({required this.employees});

  Map<String, dynamic> toJson() {
    return _$OrganizationEmployeeTestDtoToJson(this);
  }

  factory OrganizationEmployeeTestDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationEmployeeTestDtoFromJson(json);
}
