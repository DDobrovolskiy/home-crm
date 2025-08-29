import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../dto/user_employee_dto.dart';

abstract class UserEmployeeState {}

class UserEmployeeInitState extends UserEmployeeState {}

class UserEmployeeLoadedState extends UserEmployeeState {
  final UserEmployeeDto? employee;

  UserEmployeeLoadedState({required this.employee});
}

class UserEmployeeErrorState extends UserEmployeeState {
  final PortException error;

  UserEmployeeErrorState({required this.error});
}
