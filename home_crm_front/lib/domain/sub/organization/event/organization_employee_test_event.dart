import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationEmployeeTestEvent {}

class OrganizationEmployeeTestRefreshEvent
    extends OrganizationEmployeeTestEvent {}

class OrganizationEmployeeTestErrorEvent extends OrganizationEmployeeTestEvent {
  final PortException error;

  OrganizationEmployeeTestErrorEvent({required this.error});
}
