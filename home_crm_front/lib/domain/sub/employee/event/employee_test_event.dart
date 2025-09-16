import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class EmployeeTestEvent {}

class EmployeeTestRefreshEvent extends EmployeeTestEvent {}

class EmployeeTestErrorEvent extends EmployeeTestEvent {
  final PortException error;

  EmployeeTestErrorEvent({required this.error});
}
