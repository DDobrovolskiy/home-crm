import '../../../../support/exceptions/exceptions.dart';
import '../dto/response/session_test_dto.dart';

abstract class SessionState {
  abstract final bool loaded;
  abstract final SessionTestDto? data;
  abstract final PortException? error;
}

class SessionInitState extends SessionState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  SessionTestDto? get data => null;
}

class SessionLoadedState extends SessionState {
  @override
  final SessionTestDto? data;

  SessionLoadedState({required this.data});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class SessionErrorState extends SessionState {
  @override
  final PortException error;

  SessionErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  SessionTestDto? get data => null;
}
