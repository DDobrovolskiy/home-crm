import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

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

class OrganizationDeleteEvent extends OrganizationEvent {
  final int id;

  OrganizationDeleteEvent({required this.id});
}

class OrganizationErrorEvent extends OrganizationEvent {
  final PortException error;

  OrganizationErrorEvent({required this.error});
}
