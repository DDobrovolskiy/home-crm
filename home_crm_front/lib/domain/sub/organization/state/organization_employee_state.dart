import 'package:home_crm_front/domain/sub/organization/dto/response/organization_employee_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class OrganizationEmployeeState {
  abstract final bool loaded;
  abstract final OrganizationEmployeeDto? organization;
  abstract final PortException? error;
}

class OrganizationEmployeeInitState extends OrganizationEmployeeState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  OrganizationEmployeeDto? get organization => null;
}

class OrganizationEmployeeLoadedState extends OrganizationEmployeeState {
  @override
  final OrganizationEmployeeDto? organization;

  OrganizationEmployeeLoadedState({required this.organization});

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
}
