import 'package:home_crm_front/domain/sub/organization/dto/response/organization_employee_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';

abstract class OrganizationEmployeeState {
  static ScopeType scope = ScopeType.ORGANIZATION_UPDATE;
  abstract final bool loaded;
  abstract final OrganizationEmployeeDto? organization;
  abstract final PortException? error;
  abstract final bool hasEdit;
}

class OrganizationEmployeeInitState extends OrganizationEmployeeState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  OrganizationEmployeeDto? get organization => null;

  @override
  bool get hasEdit => false;
}

class OrganizationEmployeeLoadedState extends OrganizationEmployeeState {
  @override
  final OrganizationEmployeeDto? organization;

  @override
  final bool hasEdit;

  OrganizationEmployeeLoadedState(
      {required this.organization, required this.hasEdit});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class OrganizationEmployeeErrorState extends OrganizationEmployeeState {
  @override
  final PortException error;

  OrganizationEmployeeErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  OrganizationEmployeeDto? get organization => null;

  @override
  bool get hasEdit => false;
}
