import '../../../support/exceptions/exceptions.dart';
import '../dto/response/organization_role_dto.dart';

abstract class OrganizationRoleState {
  abstract final bool loaded;
  abstract final OrganizationRoleDto? organization;
  abstract final PortException? error;
}

class OrganizationRoleInitState extends OrganizationRoleState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  OrganizationRoleDto? get organization => null;
}

class OrganizationRoleLoadedState extends OrganizationRoleState {
  @override
  final OrganizationRoleDto? organization;

  OrganizationRoleLoadedState({required this.organization});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class OrganizationRoleErrorState extends OrganizationRoleState {
  @override
  final PortException error;

  OrganizationRoleErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  OrganizationRoleDto? get organization => null;
}
