import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../../../support/service/loaded.dart';
import '../dto/user_employee_dto.dart';

abstract class UserEmployeeState extends StateLoad<UserEmployeeDto> {}

class UserEmployeeInitState extends UserEmployeeState {
  @override
  UserEmployeeDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return false;
  }
}

class UserEmployeeLoadedState extends UserEmployeeState {
  final UserEmployeeDto? employee;

  UserEmployeeLoadedState({required this.employee});

  @override
  UserEmployeeDto? getBody() {
    return employee;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return true;
  }
}

class UserEmployeeErrorState extends UserEmployeeState {
  final PortException error;

  UserEmployeeErrorState({required this.error});

  @override
  UserEmployeeDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return true;
  }
}
