import 'package:home_crm_front/domain/sub/employee/dto/employee_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final int id;
  final String name;
  final String phone;
  final List<OrganizationDto> ownerOrganizations;
  final List<EmployeeDto> employeeOrganizations;

  UserDto({
    required this.id,
    required this.name,
    required this.phone,
    required this.ownerOrganizations,
    required this.employeeOrganizations,
  });

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
