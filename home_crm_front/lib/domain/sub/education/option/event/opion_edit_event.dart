import '../../../../support/exceptions/exceptions.dart';

abstract class OptionEditEvent {}

class OptionEditRefreshEvent extends OptionEditEvent {
  final int questionId;

  OptionEditRefreshEvent({required this.questionId});
}

class OptionEditLoadEvent extends OptionEditEvent {
  final int questionId;
  final int? id;

  OptionEditLoadEvent({required this.id, required this.questionId});
}

class OptionEditCreateEvent extends OptionEditEvent {
  final int questionId;
  final String text;
  final bool correct;

  OptionEditCreateEvent({
    required this.text,
    required this.correct,
    required this.questionId,
  });
}

class OptionEditUpdateEvent extends OptionEditEvent {
  final int id;
  final String text;
  final int questionId;
  final bool correct;

  OptionEditUpdateEvent({
    required this.id,
    required this.text,
    required this.correct,
    required this.questionId,
  });
}

class OptionEditDeleteEvent extends OptionEditEvent {
  final int id;
  final int questionId;

  OptionEditDeleteEvent({required this.id, required this.questionId});
}

class OptionEditErrorEvent extends OptionEditEvent {
  final PortException error;

  OptionEditErrorEvent({required this.error});
}
