import '../../../../support/exceptions/exceptions.dart';

abstract class QuestionEditEvent {}

class QuestionEditRefreshEvent extends QuestionEditEvent {
  final int testId;

  QuestionEditRefreshEvent({required this.testId});
}

class QuestionEditLoadEvent extends QuestionEditEvent {
  final int testId;
  final int? id;

  QuestionEditLoadEvent({required this.id, required this.testId});
}

class QuestionEditCreateEvent extends QuestionEditEvent {
  final String name;
  final String phone;
  final String password;
  final int roleId;
  final int testId;

  QuestionEditCreateEvent({
    required this.name,
    required this.phone,
    required this.password,
    required this.roleId,
  });
}

class QuestionEditUpdateEvent extends QuestionEditEvent {
  final int id;
  final int testId;

  QuestionEditUpdateEvent({required this.id, required this.testId});
}

class QuestionEditDeleteEvent extends QuestionEditEvent {
  final int id;
  final int testId;

  QuestionEditDeleteEvent({required this.id, required this.testId});
}

class QuestionEditErrorEvent extends QuestionEditEvent {
  final PortException error;

  QuestionEditErrorEvent({required this.error});
}
