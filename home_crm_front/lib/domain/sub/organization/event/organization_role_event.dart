import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationRoleEvent {}

class OrganizationRoleRefreshEvent extends OrganizationRoleEvent {}

class OrganizationRoleErrorEvent extends OrganizationRoleEvent {
  final PortException error;

  OrganizationRoleErrorEvent({required this.error});
}
