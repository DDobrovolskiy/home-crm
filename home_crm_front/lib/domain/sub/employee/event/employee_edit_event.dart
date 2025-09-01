import '../../../support/exceptions/exceptions.dart';

abstract class EmployeeEditEvent {}

class EmployeeEditErrorEvent extends EmployeeEditEvent {
  final PortException error;

  EmployeeEditErrorEvent({required this.error});
}
