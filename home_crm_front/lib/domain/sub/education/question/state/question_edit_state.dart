import 'package:equatable/equatable.dart';

import '../../../../support/exceptions/exceptions.dart';
import '../../../scope/scope.dart';
import '../dto/response/question_dto.dart';

abstract class QuestionEditState extends Equatable {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool isLoading;
  abstract final bool isOnlyWatch;
  abstract final bool isEndEdit;
  abstract final QuestionDto? data;
  abstract final PortException? error;

  @override
  List<Object> get props => [isLoading, isOnlyWatch, isEndEdit, ?data, ?error];
}

class QuestionEditPointState extends QuestionEditState {
  @override
  final bool isLoading;
  @override
  final bool isEndEdit;

  QuestionEditPointState({required this.isEndEdit, required this.isLoading});

  @override
  bool get isOnlyWatch => false;

  @override
  QuestionDto? get data => null;

  @override
  PortException? get error => null;
}

class QuestionEditLoadedState extends QuestionEditState {
  @override
  final QuestionDto? data;
  @override
  final bool isOnlyWatch;

  QuestionEditLoadedState({required this.data, required this.isOnlyWatch});

  @override
  bool get isEndEdit => false;

  @override
  bool get isLoading => false;

  @override
  PortException? get error => null;
}

class QuestionEditErrorState extends QuestionEditState {
  @override
  final PortException error;

  QuestionEditErrorState({required this.error});

  @override
  bool get isLoading => false;

  @override
  bool get isOnlyWatch => false;

  @override
  bool get isEndEdit => false;

  @override
  QuestionDto? get data => null;
}
