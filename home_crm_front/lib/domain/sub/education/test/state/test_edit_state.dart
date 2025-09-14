import 'package:equatable/equatable.dart';

import '../../../../support/exceptions/exceptions.dart';
import '../../../scope/scope.dart';
import '../dto/response/test_dto.dart';

abstract class TestEditState extends Equatable {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool isLoading;
  abstract final bool isOnlyWatch;
  abstract final bool isEndEdit;
  abstract final TestDto? data;
  abstract final PortException? error;

  @override
  List<Object> get props => [isLoading, isOnlyWatch, isEndEdit, ?data, ?error];
}

class TestEditPointState extends TestEditState {
  @override
  final bool isLoading;
  @override
  final bool isEndEdit;

  TestEditPointState({required this.isEndEdit, required this.isLoading});

  @override
  bool get isOnlyWatch => false;

  @override
  TestDto? get data => null;

  @override
  PortException? get error => null;
}

class TestEditLoadedState extends TestEditState {
  @override
  final TestDto? data;
  @override
  final bool isOnlyWatch;

  TestEditLoadedState({required this.data, required this.isOnlyWatch});

  @override
  bool get isEndEdit => false;

  @override
  bool get isLoading => false;

  @override
  PortException? get error => null;
}

class TestEditErrorState extends TestEditState {
  @override
  final PortException error;

  TestEditErrorState({required this.error});

  @override
  bool get isLoading => false;

  @override
  bool get isOnlyWatch => false;

  @override
  bool get isEndEdit => false;

  @override
  TestDto? get data => null;
}
