import 'package:home_crm_front/domain/sub/organization/dto/response/organization_employee_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../../support/service/loaded.dart';

abstract class OrganizationEmployeeState
    extends StateLoad<OrganizationEmployeeDto> {}

class OrganizationEmployeeInitState extends OrganizationEmployeeState {
  @override
  OrganizationEmployeeDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return false;
  }
}

class OrganizationEmployeeLoadedState extends OrganizationEmployeeState {
  final OrganizationEmployeeDto? organization;

  OrganizationEmployeeLoadedState({required this.organization});

  @override
  OrganizationEmployeeDto? getBody() {
    return organization;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return true;
  }
}

class OrganizationEmployeeErrorState extends OrganizationEmployeeState {
  final PortException error;

  OrganizationEmployeeErrorState({required this.error});

  @override
  OrganizationEmployeeDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return true;
  }
}
