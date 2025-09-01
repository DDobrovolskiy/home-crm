import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class UserOrganizationEvent {}

class UserOrganizationRefreshEvent extends UserOrganizationEvent {}

class UserOrganizationErrorEvent extends UserOrganizationEvent {
  final PortException error;

  UserOrganizationErrorEvent({required this.error});
}
