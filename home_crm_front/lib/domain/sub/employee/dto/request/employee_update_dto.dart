import 'package:json_annotation/json_annotation.dart';

part 'employee_update_dto.g.dart';

@JsonSerializable()
class EmployeeUpdateDto {
  final int id;
  final int roleId;

  EmployeeUpdateDto({required this.id, required this.roleId});

  Map<String, dynamic> toJson() {
    return _$EmployeeUpdateDtoToJson(this);
  }

  factory EmployeeUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeUpdateDtoFromJson(json);
}
