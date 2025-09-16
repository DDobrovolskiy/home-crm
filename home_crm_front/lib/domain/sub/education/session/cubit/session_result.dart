import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/request/session_result_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/repository/session_repository.dart';

import '../state/session_result_state.dart';

class SessionResultCubit extends Cubit<SessionResultState> {
  SessionResultCubit() : super(SessionResultInitState());

  late final SessionRepository _sessionRepository = GetIt.I
      .get<SessionRepository>();

  void sendResult(SessionResultDto dto) async {
    print(dto);
  }
}
