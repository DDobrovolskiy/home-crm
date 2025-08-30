import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationEditEvent {}

class OrganizationEditLoadEvent extends OrganizationEditEvent {
  final OrganizationDto? organization;

  OrganizationEditLoadEvent({required this.organization});
}

class OrganizationEditCreateEvent extends OrganizationEditEvent {
  final String name;

  OrganizationEditCreateEvent({required this.name});
}

class OrganizationEditUpdateEvent extends OrganizationEditEvent {
  final int id;
  final String name;

  OrganizationEditUpdateEvent({required this.id, required this.name});
}

class OrganizationEditDeleteEvent extends OrganizationEditEvent {
  final int id;

  OrganizationEditDeleteEvent({required this.id});
}

class OrganizationEditErrorEvent extends OrganizationEditEvent {
  final PortException error;

  OrganizationEditErrorEvent({required this.error});
}
