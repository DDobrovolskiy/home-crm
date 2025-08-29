import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

abstract class OrganizationEvent {}

class OrganizationLoad extends OrganizationEvent {
  final OrganizationDto? organization;

  OrganizationLoad({required this.organization});
}
