import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../../../support/service/loaded.dart';
import '../dto/user_organization_dto.dart';

abstract class UserOrganizationState extends StateLoad<UserOrganizationDto> {}

class UserOrganizationInitState extends UserOrganizationState {
  @override
  UserOrganizationDto? getBody() {
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

class UserOrganizationLoadedState extends UserOrganizationState {
  final UserOrganizationDto? organization;

  UserOrganizationLoadedState({required this.organization});

  @override
  UserOrganizationDto? getBody() {
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

class UserOrganizationErrorState extends UserOrganizationState {
  final PortException error;

  UserOrganizationErrorState({required this.error});

  @override
  UserOrganizationDto? getBody() {
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
