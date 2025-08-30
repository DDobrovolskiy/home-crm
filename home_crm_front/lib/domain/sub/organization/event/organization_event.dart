import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationEvent {}

class OrganizationSelectedEvent extends OrganizationEvent {
  final int id;

  OrganizationSelectedEvent({required this.id});
}

class OrganizationRefreshEvent extends OrganizationEvent {}

class OrganizationErrorEvent extends OrganizationEvent {
  final PortException error;

  OrganizationErrorEvent({required this.error});
}
