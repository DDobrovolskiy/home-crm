import 'package:equatable/equatable.dart';

import '../../../../support/exceptions/exceptions.dart';
import '../../../scope/scope.dart';
import '../dto/response/option_dto.dart';

abstract class OptionEditState extends Equatable {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool isLoading;
  abstract final bool isOnlyWatch;
  abstract final bool isEndEdit;
  abstract final OptionDto? data;
  abstract final PortException? error;

  @override
  List<Object> get props => [isLoading, isOnlyWatch, isEndEdit, ?data, ?error];
}

class OptionEditPointState extends OptionEditState {
  @override
  final bool isLoading;
  @override
  final bool isEndEdit;

  OptionEditPointState({required this.isEndEdit, required this.isLoading});

  @override
  bool get isOnlyWatch => false;

  @override
  OptionDto? get data => null;

  @override
  PortException? get error => null;
}

class OptionEditLoadedState extends OptionEditState {
  @override
  final OptionDto? data;
  @override
  final bool isOnlyWatch;

  OptionEditLoadedState({required this.data, required this.isOnlyWatch});

  @override
  bool get isEndEdit => false;

  @override
  bool get isLoading => false;

  @override
  PortException? get error => null;
}

class OptionEditErrorState extends OptionEditState {
  @override
  final PortException error;

  OptionEditErrorState({required this.error});

  @override
  bool get isLoading => false;

  @override
  bool get isOnlyWatch => false;

  @override
  bool get isEndEdit => false;

  @override
  OptionDto? get data => null;
}
