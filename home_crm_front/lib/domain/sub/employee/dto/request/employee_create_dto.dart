import 'package:json_annotation/json_annotation.dart';

part 'employee_create_dto.g.dart';

@JsonSerializable()
class EmployeeCreateDto {
  final String name;
  final String phone;
  final String password;
  final int roleId;

  EmployeeCreateDto({
    required this.name,
    required this.phone,
    required this.password,
    required this.roleId,
  });

  Map<String, dynamic> toJson() {
    return _$EmployeeCreateDtoToJson(this);
  }

  factory EmployeeCreateDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCreateDtoFromJson(json);
}
