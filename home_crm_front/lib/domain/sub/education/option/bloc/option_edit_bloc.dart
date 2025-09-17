import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_option_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/event/question_option_event.dart';
import 'package:home_crm_front/domain/sub/education/test/event/test_question_event.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../../../../support/port/port.dart';
import '../../../role/cubit/role_current_scopes.dart';
import '../../test/bloc/test_question_bloc.dart';
import '../dto/request/option_create_dto.dart';
import '../dto/request/option_delete_dto.dart';
import '../dto/request/option_update_dto.dart';
import '../event/opion_edit_event.dart';
import '../repository/option_repository.dart';
import '../state/option_edit_state.dart';

class OptionEditBloc extends Bloc<OptionEditEvent, OptionEditState> {
  late final OptionRepository _optionRepository = GetIt.I
      .get<OptionRepository>();
  late final QuestionOptionBloc _questionOptionBloc = GetIt.I
      .get<QuestionOptionBloc>();
  late final TestQuestionBloc _testQuestionBloc = GetIt.I
      .get<TestQuestionBloc>();

  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  OptionEditBloc()
    : super(OptionEditPointState(isEndEdit: false, isLoading: true)) {
    on<OptionEditRefreshEvent>((event, emit) async {
      _questionOptionBloc.add(
        QuestionOptionRefreshEvent(questionId: event.questionId),
      );
      _testQuestionBloc.add(TestQuestionRefreshEvent(testId: event.testId));
      emit.call(OptionEditPointState(isEndEdit: true, isLoading: false));
    });
    on<OptionEditLoadEvent>((event, emit) async {
      emit.call(OptionEditPointState(isEndEdit: false, isLoading: true));
      var bool = await _roleCurrentScopesCubit.checkScopeNoSafe(
        OptionEditState.scope,
      );
      if (event.id == null) {
        emit.call(OptionEditLoadedState(data: null, isOnlyWatch: false));
      } else {
        var employee = await _optionRepository.get(event.id!);
        emit.call(OptionEditLoadedState(data: employee, isOnlyWatch: false));
      }
    });
    on<OptionEditCreateEvent>((event, emit) async {
      await _optionRepository.create(
        OptionCreateDto(
          correct: event.correct,
          text: event.text,
          questionId: event.questionId,
        ),
      );
      add(OptionEditRefreshEvent(
          questionId: event.questionId, testId: event.testId));
    });
    on<OptionEditUpdateEvent>((event, emit) async {
      await _optionRepository.update(
        OptionUpdateDto(id: event.id, correct: event.correct, text: event.text),
      );
      add(OptionEditRefreshEvent(
          questionId: event.questionId, testId: event.testId));
    });
    on<OptionEditDeleteEvent>((event, emit) async {
      await _optionRepository.delete(OptionDeleteDto(id: event.id));
      add(OptionEditRefreshEvent(
          questionId: event.questionId, testId: event.testId));
    });
    on<OptionEditErrorEvent>((event, emit) {
      Stamp.showTemporarySnackbar(null, event.error.message);
      emit.call(OptionEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OptionEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
