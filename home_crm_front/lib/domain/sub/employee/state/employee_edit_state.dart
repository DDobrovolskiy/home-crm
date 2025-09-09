import 'package:equatable/equatable.dart';

import '../../../support/exceptions/exceptions.dart';
import '../dto/response/employee_dto.dart';

abstract class EmployeeEditState extends Equatable {
  abstract final bool isLoading;
  abstract final bool isOnlyWatch;
  abstract final bool isEndEdit;
  abstract final EmployeeDto? data;
  abstract final PortException? error;

  @override
  List<Object> get props => [isLoading, isOnlyWatch, isEndEdit, ?data, ?error];
}

class EmployeeEditPointState extends EmployeeEditState {
  @override
  final bool isLoading;
  @override
  final bool isEndEdit;

  EmployeeEditPointState({required this.isEndEdit, required this.isLoading});

  @override
  bool get isOnlyWatch => false;

  @override
  EmployeeDto? get data => null;

  @override
  PortException? get error => null;
}

class EmployeeEditLoadedState extends EmployeeEditState {
  @override
  final EmployeeDto? data;
  @override
  final bool isOnlyWatch;

  EmployeeEditLoadedState({required this.data, required this.isOnlyWatch});

  @override
  bool get isEndEdit => false;

  @override
  bool get isLoading => false;

  @override
  PortException? get error => null;
}

class EmployeeEditErrorState extends EmployeeEditState {
  @override
  final PortException error;

  EmployeeEditErrorState({required this.error});

  @override
  bool get isLoading => false;

  @override
  bool get isOnlyWatch => false;

  @override
  bool get isEndEdit => false;

  @override
  EmployeeDto? get data => null;
}
