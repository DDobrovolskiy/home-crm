import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class OrganizationTestEvent {}

class OrganizationTestRefreshEvent extends OrganizationTestEvent {}

class OrganizationTestErrorEvent extends OrganizationTestEvent {
  final PortException error;

  OrganizationTestErrorEvent({required this.error});
}
