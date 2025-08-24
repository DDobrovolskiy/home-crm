import 'package:home_crm_front/domain/sub/employee/dto/employee_dto.dart';
import 'package:home_crm_front/domain/sub/organization/store/organization_state.dart';
import 'package:home_crm_front/domain/sub/role/store/role_state.dart';
import 'package:home_crm_front/domain/sub/user/store/user_state.dart';

class EmployeeState {
  final int id;
  final UserState user;
  final OrganizationState organization;
  final RoleState role;

  EmployeeState({
    required this.id,
    required this.user,
    required this.organization,
    required this.role,
  });

  static EmployeeState from(EmployeeDto dto) {
    return EmployeeState(
      id: dto.id,
      user: UserState.fromBase(dto.user),
      organization: OrganizationState.from(dto.organization),
      role: RoleState.from(dto.role),
    );
  }
}
