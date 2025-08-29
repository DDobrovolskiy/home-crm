import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class UserEmployeeEvent {}

class UserEmployeeLoadEvent extends UserEmployeeEvent {}

class UserEmployeeErrorEvent extends UserEmployeeEvent {
  final PortException error;

  UserEmployeeErrorEvent({required this.error});
}
