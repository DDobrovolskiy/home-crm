import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/test/bloc/test_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/test/event/test_edit_event.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../../../../support/port/port.dart';
import '../../../role/cubit/role_current_scopes.dart';
import '../event/question_edit_event.dart';
import '../repository/question_repository.dart';
import '../state/question_edit_state.dart';

class QuestionEditBloc extends Bloc<QuestionEditEvent, QuestionEditState> {
  late final QuestionRepository _questionRepository = GetIt.instance
      .get<QuestionRepository>();
  late final TestEditBloc _testEditBloc = GetIt.instance.get<TestEditBloc>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  QuestionEditBloc()
    : super(QuestionEditPointState(isEndEdit: false, isLoading: true)) {
    on<QuestionEditRefreshEvent>((event, emit) async {
      _testEditBloc.add(TestEditLoadEvent(id: event.testId));
      emit.call(QuestionEditPointState(isEndEdit: true, isLoading: false));
    });
    on<QuestionEditLoadEvent>((event, emit) async {
      emit.call(QuestionEditPointState(isEndEdit: false, isLoading: true));
      var bool = await _roleCurrentScopesCubit.checkScopeNoSafe(
        QuestionEditState.scope,
      );
      if (event.id == null) {
        emit.call(QuestionEditLoadedState(data: null, isOnlyWatch: false));
      } else {
        var employee = await _questionRepository.getEmployeeLocalStorage(
          event.id!,
        );
        emit.call(QuestionEditLoadedState(data: employee, isOnlyWatch: false));
      }
    });
    on<QuestionEditCreateEvent>((event, emit) async {
      await _questionRepository.create(
        QuestionCreateDto(
          name: event.name,
          phone: event.phone,
          password: event.password,
          roleId: event.roleId,
        ),
      );
      add(QuestionEditRefreshEvent(testId: event.testId));
    });
    on<QuestionEditUpdateEvent>((event, emit) async {
      await _questionRepository.update(
        QuestionUpdateDto(id: event.id, roleId: event.roleId),
      );
      add(QuestionEditRefreshEvent(testId: event.testId));
    });
    on<QuestionEditDeleteEvent>((event, emit) async {
      await _questionRepository.delete(QuestionDeleteDto(id: event.id));
      add(QuestionEditRefreshEvent(testId: event.testId));
    });
    on<QuestionEditErrorEvent>((event, emit) {
      Stamp.showTemporarySnackbar(null, event.error.message);
      emit.call(QuestionEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(QuestionEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
