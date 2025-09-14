import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_employees_dto.g.dart';

@JsonSerializable()
class TestEmployeesDto {
  final List<EmployeeDto> employees;

  TestEmployeesDto({required this.employees});

  Map<String, dynamic> toJson() {
    return _$TestEmployeesDtoToJson(this);
  }

  factory TestEmployeesDto.fromJson(Map<String, dynamic> json) =>
      _$TestEmployeesDtoFromJson(json);
}
