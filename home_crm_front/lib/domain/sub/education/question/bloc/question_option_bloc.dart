import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/question/repository/question_repository.dart';

import '../../../../support/port/port.dart';
import '../../../role/cubit/role_current_scopes.dart';
import '../event/question_option_event.dart';
import '../state/question_option_state.dart';

class QuestionOptionBloc
    extends Bloc<QuestionOptionEvent, QuestionOptionState> {
  late final QuestionRepository _questionRepository = GetIt.I
      .get<QuestionRepository>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  QuestionOptionBloc() : super(QuestionOptionInitState()) {
    on<QuestionOptionRefreshEvent>((event, emit) async {
      emit.call(QuestionOptionInitState());
      var value = await _questionRepository.getOptions(event.questionId);
      var hasEdit = await _roleCurrentScopesCubit.checkScope(
        QuestionOptionState.scope,
      );
      emit.call(QuestionOptionLoadedState(hasEdit: hasEdit, data: value));
    });
    on<QuestionOptionErrorEvent>((event, emit) async {
      emit.call(QuestionOptionErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(QuestionOptionErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
