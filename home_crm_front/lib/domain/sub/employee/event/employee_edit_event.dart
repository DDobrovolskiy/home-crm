import '../../../support/exceptions/exceptions.dart';

abstract class EmployeeEditEvent {
}

class EmployeeEditRefreshEvent extends EmployeeEditEvent {
}

class EmployeeEditLoadEvent extends EmployeeEditEvent {
  final int? id;

  EmployeeEditLoadEvent({required this.id});
}

class EmployeeEditCreateEvent extends EmployeeEditEvent {
  final String name;
  final String phone;
  final String password;
  final int roleId;

  EmployeeEditCreateEvent(
      {required this.name, required this.phone, required this.password, required this.roleId});
}

class EmployeeEditUpdateEvent extends EmployeeEditEvent {
  final int id;
  final int roleId;

  EmployeeEditUpdateEvent({required this.id, required this.roleId});
}

class EmployeeEditDeleteEvent extends EmployeeEditEvent {
  final int id;

  EmployeeEditDeleteEvent({required this.id});
}

class EmployeeEditErrorEvent extends EmployeeEditEvent {
  final PortException error;

  EmployeeEditErrorEvent({required this.error});
}