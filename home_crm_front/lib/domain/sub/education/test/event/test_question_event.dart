import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class TestQuestionEvent {}

class TestQuestionRefreshEvent extends TestQuestionEvent {
  final int testId;

  TestQuestionRefreshEvent({required this.testId});
}

class TestQuestionErrorEvent extends TestQuestionEvent {
  final PortException error;

  TestQuestionErrorEvent({required this.error});
}
