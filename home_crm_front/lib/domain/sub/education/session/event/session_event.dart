import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class SessionEvent {}

class SessionRefreshEvent extends SessionEvent {
  final int testId;
  final int employeeId;

  SessionRefreshEvent({required this.testId, required this.employeeId});
}

class SessionErrorEvent extends SessionEvent {
  final PortException error;

  SessionErrorEvent({required this.error});
}
