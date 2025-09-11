import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/repository/role_repository.dart';

import '../../../support/port/port.dart';
import '../event/role_current_event.dart';
import '../event/role_current_scopes_event.dart';
import '../state/role_current_scopes_state.dart';
import '../state/role_current_state.dart';

class RoleCurrentBloc extends Bloc<RoleCurrentEvent, RoleCurrentState> {
  late final RoleRepository _roleRepository = GetIt.instance
      .get<RoleRepository>();

  RoleCurrentBloc() : super(RoleCurrentInitState()) {
    on<RoleCurrentRefreshEvent>((event, emit) async {
      emit.call(RoleCurrentInitState());
      var role = await _roleRepository.roleCurrent();
      emit.call(RoleCurrentLoadedState(role: role));
    });
    on<RoleCurrentErrorEvent>((event, emit) async {
      emit.call(RoleCurrentErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(RoleCurrentErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
