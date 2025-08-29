import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../dto/user_organization_dto.dart';

abstract class UserOrganizationState {}

class UserOrganizationInitState extends UserOrganizationState {}

class UserOrganizationLoadedState extends UserOrganizationState {
  final UserOrganizationDto? organization;

  UserOrganizationLoadedState({required this.organization});
}

class UserOrganizationErrorState extends UserOrganizationState {
  final PortException error;

  UserOrganizationErrorState({required this.error});
}
