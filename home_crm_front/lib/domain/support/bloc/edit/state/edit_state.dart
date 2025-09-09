import 'package:equatable/equatable.dart';

import '../../../exceptions/exceptions.dart';

abstract class EditState<T> extends Equatable {
  abstract final bool isLoading;
  abstract final bool isOnlyWatch;
  abstract final bool isEndEdit;
  abstract final T? data;
  abstract final PortException? error;

  @override
  List<Object> get props => [isLoading, isOnlyWatch, isEndEdit, ?data, ?error];
}

class EditPointState<T> extends EditState<T> {
  @override
  final bool isLoading;
  @override
  final bool isEndEdit;

  EditPointState({required this.isEndEdit, required this.isLoading});

  @override
  bool get isOnlyWatch => false;

  @override
  T? get data => null;

  @override
  PortException? get error => null;
}

class EditLoadedState<T> extends EditState<T> {
  @override
  final T? data;
  @override
  final bool isOnlyWatch;

  EditLoadedState({required this.data, required this.isOnlyWatch});

  @override
  bool get isEndEdit => false;

  @override
  bool get isLoading => false;

  @override
  PortException? get error => null;
}

class EditErrorState<T> extends EditState<T> {
  @override
  final PortException error;

  EditErrorState({required this.error});

  @override
  bool get isLoading => false;

  @override
  bool get isOnlyWatch => false;

  @override
  bool get isEndEdit => false;

  @override
  T? get data => null;
}
