import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/request/session_get_or_create_dto.dart';

import '../../../../support/port/port.dart';
import '../event/session_event.dart';
import '../repository/session_repository.dart';
import '../state/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  late final SessionRepository _sessionRepository = GetIt.I
      .get<SessionRepository>();

  SessionBloc() : super(SessionInitState()) {
    on<SessionRefreshEvent>((event, emit) async {
      emit.call(SessionInitState());
      var value = await _sessionRepository.getTest(
        SessionGetOrCreateDto(
          testId: event.testId,
          employeeId: event.employeeId,
        ),
      );
      emit.call(SessionLoadedState(data: value));
    });
    on<SessionErrorEvent>((event, emit) async {
      emit.call(SessionErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(SessionErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
