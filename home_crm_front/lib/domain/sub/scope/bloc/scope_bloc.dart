import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../support/port/port.dart';
import '../event/scope_event.dart';
import '../repository/scope_repository.dart';
import '../state/scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  late final ScopeRepository _scopeRepository = GetIt.instance
      .get<ScopeRepository>();

  ScopeBloc() : super(ScopeInitState()) {
    on<ScopeRefreshEvent>((event, emit) async {
      emit.call(ScopeInitState());
      var scope = await _scopeRepository.scopes();
      emit.call(ScopeLoadedState(scopes: []));
    });
    on<ScopeErrorEvent>((event, emit) async {
      emit.call(ScopeErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(ScopeErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
