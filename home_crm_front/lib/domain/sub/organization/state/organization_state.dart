import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class OrganizationState {}

class OrganizationInitial extends OrganizationState {}

class OrganizationCreateState extends OrganizationState {}

class OrganizationUpdateState extends OrganizationState {
  final OrganizationDto organization;
  OrganizationUpdateState({required this.organization});
}

class OrganizationErrorState extends OrganizationState {
  final PortException error;

  OrganizationErrorState({required this.error});
}

class OrganizationSuccessState extends OrganizationState {}
