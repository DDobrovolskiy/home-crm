import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_employee_dto.g.dart';

@JsonSerializable()
class UserEmployeeDto {
  final List<EmployeeDto> employees;

  UserEmployeeDto({required this.employees});

  Map<String, dynamic> toJson() {
    return _$UserEmployeeDtoToJson(this);
  }

  factory UserEmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$UserEmployeeDtoFromJson(json);
}
