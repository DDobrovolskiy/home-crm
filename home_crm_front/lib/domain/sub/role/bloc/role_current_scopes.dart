import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/repository/role_repository.dart';

import '../../../support/port/port.dart';
import '../event/role_current_scopes_event.dart';
import '../state/role_current_scopes_state.dart';

class RoleCurrentScopesBloc
    extends Bloc<RoleCurrentScopesEvent, RoleCurrentScopesState> {
  late final RoleRepository _roleRepository = GetIt.instance
      .get<RoleRepository>();

  RoleCurrentScopesBloc() : super(RoleCurrentScopesInitState()) {
    on<RoleCurrentScopesRefreshEvent>((event, emit) async {
      emit.call(RoleCurrentScopesInitState());
      var roleScopes = await _roleRepository.roleCurrentScopes();
      emit.call(RoleCurrentScopesLoadedState(role: roleScopes));
    });
    on<RoleCurrentScopesErrorEvent>((event, emit) async {
      emit.call(RoleCurrentScopesErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(RoleCurrentScopesErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
