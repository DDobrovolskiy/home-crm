import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationEmployeeEvent {}

class OrganizationEmployeeRefreshEvent extends OrganizationEmployeeEvent {}

class OrganizationEmployeeErrorEvent extends OrganizationEmployeeEvent {
  final PortException error;

  OrganizationEmployeeErrorEvent({required this.error});
}
