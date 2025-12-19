import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';

import '../../organization/service/organization_service.dart';
import '../../scope/repository/scope_repository.dart';
import '../dto/request/role_create_dto.dart';
import '../dto/request/role_delete_dto.dart';
import '../dto/request/role_update_dto.dart';
import '../dto/response/role_dto.dart';
import '../repository/role_repository.dart';

class RoleService {
  late final RoleRepository _roleRepository = GetIt.instance
      .get<RoleRepository>();
  late final OrganizationService _organizationCurrentService = GetIt.instance
      .get<OrganizationService>();
  late final ScopeRepository _scopeRepository = GetIt.instance
      .get<ScopeRepository>();

  Future<RoleDto?> addRole(RoleCreateDto role) async {
    RoleDto? roleNew = await _roleRepository.roleCreate(role);
    _organizationCurrentService.refreshOrganizationRoles(Loaded.ifLoad);
    return roleNew;
  }

  Future<RoleDto?> updateRole(RoleUpdateDto role) async {
    RoleDto? roleNew = await _roleRepository.roleUpdate(role);
    _organizationCurrentService.refreshOrganizationRoles(Loaded.ifLoad);
    return roleNew;
  }

  Future<bool> deleteRole(RoleDeleteDto role) async {
    await _roleRepository.roleDelete(role);
    _organizationCurrentService.refreshOrganizationRoles(Loaded.ifLoad);
    return true;
  }

}
