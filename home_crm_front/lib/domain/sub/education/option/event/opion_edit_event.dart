import '../../../../support/exceptions/exceptions.dart';

abstract class OptionEditEvent {}

class OptionEditRefreshEvent extends OptionEditEvent {
  final int questionId;
  final int testId;

  OptionEditRefreshEvent({required this.questionId, required this.testId,});
}

class OptionEditLoadEvent extends OptionEditEvent {
  final int questionId;
  final int testId;
  final int? id;

  OptionEditLoadEvent(
      {required this.id, required this.questionId, required this.testId,});
}

class OptionEditCreateEvent extends OptionEditEvent {
  final int questionId;
  final int testId;
  final String text;
  final bool correct;

  OptionEditCreateEvent({
    required this.text,
    required this.correct,
    required this.questionId,
    required this.testId,
  });
}

class OptionEditUpdateEvent extends OptionEditEvent {
  final int testId;
  final int id;
  final String text;
  final int questionId;
  final bool correct;

  OptionEditUpdateEvent({
    required this.id,
    required this.text,
    required this.correct,
    required this.questionId,
    required this.testId,
  });
}

class OptionEditDeleteEvent extends OptionEditEvent {
  final int testId;
  final int id;
  final int questionId;

  OptionEditDeleteEvent(
      {required this.id, required this.questionId, required this.testId,});
}

class OptionEditErrorEvent extends OptionEditEvent {
  final PortException error;

  OptionEditErrorEvent({required this.error});
}
