import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

abstract class OrganizationEvent {}

class OrganizationLoadEvent extends OrganizationEvent {
  final OrganizationDto? organization;

  OrganizationLoadEvent({required this.organization});
}

class OrganizationCreateEvent extends OrganizationEvent {
  final String name;

  OrganizationCreateEvent({required this.name});
}

class OrganizationUpdateEvent extends OrganizationEvent {
  final int id;
  final String name;

  OrganizationUpdateEvent({required this.id, required this.name});
}
