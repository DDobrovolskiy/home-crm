import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class OrganizationState {}

class OrganizationUnSelectedState extends OrganizationState {}

class OrganizationSelectedState extends OrganizationState {
  final OrganizationDto organization;

  OrganizationSelectedState({required this.organization});
}

class OrganizationErrorState extends OrganizationState {
  final PortException error;

  OrganizationErrorState({required this.error});
}
