import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/request/session_result_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/repository/session_repository.dart';

import '../../../employee/bloc/employee_test_bloc.dart';
import '../../../employee/event/employee_test_event.dart';
import '../../result/dto/response/result_dto.dart';
import '../state/session_result_state.dart';

class SessionResultCubit extends Cubit<SessionResultState> {
  SessionResultCubit() : super(SessionResultInitState());

  late final SessionRepository _sessionRepository = GetIt.I
      .get<SessionRepository>();

  Future<ResultDto?> sendResult(SessionResultDto dto) async {
    var value = await _sessionRepository.sendResult(dto);
    GetIt.I.get<EmployeeTestBloc>().add(EmployeeTestRefreshEvent());
    return value;
  }
}
