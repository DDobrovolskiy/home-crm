import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class QuestionOptionEvent {}

class QuestionOptionRefreshEvent extends QuestionOptionEvent {
  final int questionId;

  QuestionOptionRefreshEvent({required this.questionId});
}

class QuestionOptionErrorEvent extends QuestionOptionEvent {
  final PortException error;

  QuestionOptionErrorEvent({required this.error});
}
