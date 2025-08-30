import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../support/port/port.dart';
import '../event/user_employee_event.dart';
import '../repository/user_repository.dart';
import '../user_state/user_employee_state.dart';

class UserEmployeeBloc extends Bloc<UserEmployeeEvent, UserEmployeeState> {
  final UserRepository _repository = UserRepository();

  UserEmployeeBloc() : super(UserEmployeeInitState()) {
    on<UserEmployeeLoadEvent>((event, emit) async {
      emit.call(UserEmployeeInitState());
      final employee = await _repository.employee();
      emit.call(UserEmployeeLoadedState(employee: employee));
    });
    on<UserEmployeeErrorEvent>((event, emit) {
      emit.call(UserEmployeeErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(UserEmployeeErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
