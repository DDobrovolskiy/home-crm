import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationCurrentEvent {}

class OrganizationUnSelectedEvent extends OrganizationCurrentEvent {}

class OrganizationSelectedEvent extends OrganizationCurrentEvent {
  final int id;

  OrganizationSelectedEvent({required this.id});
}

class OrganizationRefreshEvent extends OrganizationCurrentEvent {}

class OrganizationErrorEvent extends OrganizationCurrentEvent {
  final PortException error;

  OrganizationErrorEvent({required this.error});
}
