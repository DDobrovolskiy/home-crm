import '../../../../support/exceptions/exceptions.dart';
import '../../../scope/scope.dart';
import '../dto/response/test_questions_dto.dart';

abstract class TestQuestionState {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool loaded;
  abstract final TestQuestionsDto? test;
  abstract final PortException? error;
  abstract final bool hasEdit;
}

class TestQuestionInitState extends TestQuestionState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  TestQuestionsDto? get test => null;

  @override
  bool get hasEdit => false;
}

class TestQuestionLoadedState extends TestQuestionState {
  @override
  final TestQuestionsDto? test;
  @override
  final bool hasEdit;

  TestQuestionLoadedState({required this.test, required this.hasEdit});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class TestQuestionErrorState extends TestQuestionState {
  @override
  final PortException error;

  TestQuestionErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  TestQuestionsDto? get test => null;

  @override
  bool get hasEdit => false;
}
