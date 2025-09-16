import 'package:home_crm_front/domain/sub/employee/dto/response/employee_tests_view_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class EmployeeTestState {
  abstract final bool loaded;
  abstract final EmployeeTestsViewDto? data;
  abstract final PortException? error;
}

class EmployeeTestInitState extends EmployeeTestState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  EmployeeTestsViewDto? get data => null;
}

class EmployeeTestLoadedState extends EmployeeTestState {
  @override
  final EmployeeTestsViewDto? data;

  EmployeeTestLoadedState({required this.data});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class EmployeeTestErrorState extends EmployeeTestState {
  @override
  final PortException error;

  EmployeeTestErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  EmployeeTestsViewDto? get data => null;
}
