import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';
import '../dto/response/organization_role_dto.dart';

abstract class OrganizationRoleState {
  static ScopeType scope = ScopeType.ORGANIZATION_UPDATE;
  abstract final bool loaded;
  abstract final OrganizationRoleDto? organization;
  abstract final PortException? error;
  abstract final bool hasEdit;
}

class OrganizationRoleInitState extends OrganizationRoleState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  OrganizationRoleDto? get organization => null;

  @override
  bool get hasEdit => false;
}

class OrganizationRoleLoadedState extends OrganizationRoleState {
  @override
  final OrganizationRoleDto? organization;
  @override
  final bool hasEdit;

  OrganizationRoleLoadedState(
      {required this.organization, required this.hasEdit});

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

  @override
  bool get hasEdit => false;
}
