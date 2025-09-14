import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../support/port/port.dart';
import '../../../role/cubit/role_current_scopes.dart';
import '../event/test_question_event.dart';
import '../repository/test_repository.dart';
import '../state/test_question_state.dart';

class TestQuestionBloc extends Bloc<TestQuestionEvent, TestQuestionState> {
  late final TestRepository _testRepository = GetIt.I.get<TestRepository>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  TestQuestionBloc() : super(TestQuestionInitState()) {
    on<TestQuestionRefreshEvent>((event, emit) async {
      emit.call(TestQuestionInitState());
      var value = await _testRepository.getTestQuestions(event.testId);
      var hasEdit = await _roleCurrentScopesCubit.checkScope(
        TestQuestionState.scope,
      );
      emit.call(TestQuestionLoadedState(hasEdit: hasEdit, test: value));
    });
    on<TestQuestionErrorEvent>((event, emit) async {
      emit.call(TestQuestionErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(TestQuestionErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
