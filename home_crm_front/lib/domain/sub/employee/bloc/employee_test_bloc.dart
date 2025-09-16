import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../support/port/port.dart';
import '../event/employee_test_event.dart';
import '../repository/employee_repository.dart';
import '../state/employee_test_state.dart';

class EmployeeTestBloc extends Bloc<EmployeeTestEvent, EmployeeTestState> {
  late final EmployeeRepository _employeeRepository = GetIt.instance
      .get<EmployeeRepository>();

  EmployeeTestBloc() : super(EmployeeTestInitState()) {
    on<EmployeeTestRefreshEvent>((event, emit) async {
      emit.call(EmployeeTestInitState());
      var data = await _employeeRepository.getCurrentEmployeeTest();
      emit.call(EmployeeTestLoadedState(data: data));
    });
    on<EmployeeTestErrorEvent>((event, emit) async {
      emit.call(EmployeeTestErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(EmployeeTestErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
