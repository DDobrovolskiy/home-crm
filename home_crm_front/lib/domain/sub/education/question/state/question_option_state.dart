import '../../../../support/exceptions/exceptions.dart';
import '../../../scope/scope.dart';
import '../dto/response/question_options_dto.dart';

abstract class QuestionOptionState {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool loaded;
  abstract final QuestionOptionsDto? data;
  abstract final PortException? error;
  abstract final bool hasEdit;
}

class QuestionOptionInitState extends QuestionOptionState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  QuestionOptionsDto? get data => null;

  @override
  bool get hasEdit => false;
}

class QuestionOptionLoadedState extends QuestionOptionState {
  @override
  final QuestionOptionsDto? data;
  @override
  final bool hasEdit;

  QuestionOptionLoadedState({required this.data, required this.hasEdit});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class QuestionOptionErrorState extends QuestionOptionState {
  @override
  final PortException error;

  QuestionOptionErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  QuestionOptionsDto? get data => null;

  @override
  bool get hasEdit => false;
}
