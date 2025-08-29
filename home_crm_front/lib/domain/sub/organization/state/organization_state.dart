import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

abstract class OrganizationState {}

class OrganizationInitial extends OrganizationState {}

class OrganizationCreateState extends OrganizationState {}

class OrganizationUpdateState extends OrganizationState {
  final OrganizationDto organization;

  OrganizationUpdateState({required this.organization});
}
