import '../../../support/exceptions/exceptions.dart';
import '../../../support/service/loaded.dart';
import '../dto/response/organization_role_dto.dart';

abstract class OrganizationRoleState extends StateLoad<OrganizationRoleDto> {}

class OrganizationRoleInitState extends OrganizationRoleState {
  @override
  bool loaded() {
    return false;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  OrganizationRoleDto? getBody() {
    return null;
  }
}

class OrganizationRoleLoadedState extends OrganizationRoleState {
  final OrganizationRoleDto organization;

  OrganizationRoleLoadedState({required this.organization});

  @override
  PortException? getError() {
    return null;
  }

  @override
  OrganizationRoleDto? getBody() {
    return organization;
  }

  @override
  bool loaded() {
    return true;
  }
}

class OrganizationRoleErrorState extends OrganizationRoleState {
  final PortException error;

  @override
  PortException? getError() {
    return error;
  }

  OrganizationRoleErrorState({required this.error});

  @override
  OrganizationRoleDto? getBody() {
    return null;
  }

  @override
  bool loaded() {
    return true;
  }
}
