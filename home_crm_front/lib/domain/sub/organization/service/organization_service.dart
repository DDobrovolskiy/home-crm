import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/user/service/user_service.dart';

import '../../../support/service/loaded.dart';
import '../../scope/scope.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_employee_bloc.dart';
import '../bloc/organization_role_bloc.dart';
import '../dto/request/organization_create_dto.dart';
import '../dto/request/organization_delete_dto.dart';
import '../dto/request/organization_update_dto.dart';
import '../dto/response/organization_dto.dart';
import '../event/organization_employee_event.dart';
import '../event/organization_event.dart';
import '../event/organization_role_event.dart';
import '../repository/organization_repository.dart';

class OrganizationService {
  static ScopeType scope = ScopeType.ORGANIZATION_UPDATE;

  late final OrganizationRepository _organizationRepository = GetIt.instance
      .get<OrganizationRepository>();

  late final OrganizationCurrentBloc _organizationBloc = GetIt.instance
      .get<OrganizationCurrentBloc>();
  late final OrganizationEmployeeBloc _organizationEmployeeBloc = GetIt.instance
      .get<OrganizationEmployeeBloc>();
  late final OrganizationRoleBloc _organizationRoleBloc = GetIt.instance
      .get<OrganizationRoleBloc>();

  late final UserService _userService = GetIt.I.get<UserService>();

  void refreshOrganizationCurrent(Loaded loaded) {
    if (loaded.needLoad(_organizationBloc.state)) {
      _organizationBloc.add(OrganizationRefreshEvent());
    }
  }

  void refreshOrganizationRoles(Loaded loaded) {
    if (loaded.needLoad(_organizationRoleBloc.state)) {
      _organizationRoleBloc.add(OrganizationRoleRefreshEvent());
    }
  }

  void refreshOrganizationEmployees(Loaded loaded) {
    if (loaded.needLoad(_organizationEmployeeBloc.state)) {
      _organizationEmployeeBloc.add(OrganizationEmployeeRefreshEvent());
    }
  }

  Future<OrganizationDto?> addOrganization(
      OrganizationCreateDto organization) async {
    OrganizationDto? result = await _organizationRepository.organizationCreate(
        organization);
    _userService.refreshUserOrganization(Loaded.ifLoad);
    return result;
  }

  Future<OrganizationDto?> updateOrganization(
      OrganizationUpdateDto organization) async {
    OrganizationDto? result = await _organizationRepository.organizationUpdate(
        organization);
    _userService.refreshUserOrganization(Loaded.ifLoad);
    return result;
  }

  Future<bool> deleteOrganization(OrganizationDeleteDto organization) async {
    await _organizationRepository.organizationDelete(organization);
    _userService.refreshUserOrganization(Loaded.ifLoad);
    return true;
  }


  bool isEditor(ScopeType scope) {
    var state = _organizationBloc.state;
    if (state.getBody() != null) {
      return state.getBody()?.include(scope) ?? false;
    }
    return false;
  }
}
