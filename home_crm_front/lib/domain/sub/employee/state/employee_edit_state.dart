import '../../../support/exceptions/exceptions.dart';

abstract class EmployeeEditState {}

class EmployeeEditInitState extends EmployeeEditState {}

class EmployeeEditErrorState extends EmployeeEditState {
  final PortException error;

  EmployeeEditErrorState({required this.error});
}
