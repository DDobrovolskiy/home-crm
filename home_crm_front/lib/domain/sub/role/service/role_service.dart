import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';

import '../../organization/service/organization_service.dart';
import '../../scope/dto/response/scope_dto.dart';
import '../../scope/repository/scope_repository.dart';
import '../../scope/scope.dart';
import '../dto/request/role_create_dto.dart';
import '../dto/request/role_delete_dto.dart';
import '../dto/request/role_update_dto.dart';
import '../dto/response/role_dto.dart';
import '../repository/role_repository.dart';

class RoleService {
  static ScopeType scope = ScopeType.ORGANIZATION_UPDATE;
  late final RoleRepository _roleRepository = GetIt.instance
      .get<RoleRepository>();
  late final OrganizationCurrentService _organizationCurrentService = GetIt
      .instance
      .get<OrganizationCurrentService>();
  late final ScopeRepository _scopeRepository = GetIt.instance
      .get<ScopeRepository>();

  void refreshRole() {
    _organizationCurrentService.refreshOrganizationRoles(Loaded.ifLoad);
  }

  Future<RoleDto?> addRole(RoleCreateDto role) async {
    RoleDto? roleNew = await _roleRepository.roleCreate(role);
    refreshRole();
    return roleNew;
  }

  Future<RoleDto?> updateRole(RoleUpdateDto role) async {
    RoleDto? roleNew = await _roleRepository.roleUpdate(role);
    refreshRole();
    return roleNew;
  }

  Future<bool> deleteRole(RoleDeleteDto role) async {
    await _roleRepository.roleDelete(role);
    refreshRole();
    return true;
  }

  Future<List<ScopeDTO>?> getAllScopes() async {
    return await _scopeRepository.scopes();
  }
}
