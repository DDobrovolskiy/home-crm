import 'package:home_crm_front/domain/sub/employee/store/employee_state.dart';
import 'package:home_crm_front/domain/sub/organization/store/organization_state.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_dto.dart';

import '../dto/user_base_dto.dart';

class UserState {
  final int id;
  final String name;
  final String phone;
  final List<OrganizationState> ownerOrganizations;
  final List<EmployeeState> employeeOrganizations;
  int chooseOrganizationId = 0;
  bool createOrganization = false;
  bool hasError = false;

  UserState({
    required this.id,
    required this.name,
    required this.phone,
    required this.ownerOrganizations,
    required this.employeeOrganizations,
  });

  static UserState fromBase(UserBaseDto dto) {
    return UserState(
      id: dto.id,
      name: dto.name,
      phone: dto.phone,
      ownerOrganizations: List.empty(),
      employeeOrganizations: List.empty(),
    );
  }

  static UserState from(UserDto dto) {
    return UserState(
      id: dto.id,
      name: dto.name,
      phone: dto.phone,
      ownerOrganizations: dto.ownerOrganizations
          .map((o) => OrganizationState.from(o))
          .toList(),
      employeeOrganizations: dto.employeeOrganizations
          .map((e) => EmployeeState.from(e))
          .toList(),
    );
  }
}
