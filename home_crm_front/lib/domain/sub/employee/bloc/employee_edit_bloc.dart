import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../support/port/port.dart';
import '../event/employee_edit_event.dart';
import '../repository/employee_repository.dart';
import '../state/employee_edit_state.dart';

class EmployeeEditBloc extends Bloc<EmployeeEditEvent, EmployeeEditState> {
  late final EmployeeRepository _repository = GetIt.instance
      .get<EmployeeRepository>();

  EmployeeEditBloc() : super(EmployeeEditInitState()) {
    on<EmployeeEditErrorEvent>((event, emit) {
      emit.call(EmployeeEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(EmployeeEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
