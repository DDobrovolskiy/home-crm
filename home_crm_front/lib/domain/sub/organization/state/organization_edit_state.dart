import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class OrganizationEditState {}

class OrganizationEditInitState extends OrganizationEditState {}

class OrganizationEditCreateState extends OrganizationEditState {}

class OrganizationEditUpdateState extends OrganizationEditState {
  final OrganizationDto organization;

  OrganizationEditUpdateState({required this.organization});
}

class OrganizationEditErrorState extends OrganizationEditState {
  final PortException error;

  OrganizationEditErrorState({required this.error});
}

class OrganizationEditSuccessState extends OrganizationEditState {}
