import '../exceptions/exceptions.dart';

enum Loaded {
  force,
  ifNotLoad,
  ifLoad;

  bool needLoad(IsHasError state) {
    if (this == Loaded.force) {
      return true;
    } else if (this == Loaded.ifLoad &&
        (state.loaded() == true || state.getError() != null)) {
      return true;
    } else if (this == Loaded.ifNotLoad && state.loaded() == false) {
      return true;
    } else {
      return false;
    }
  }
}

abstract class StateLoad<T> extends IsHasError {
  T? getBody();
}

abstract class IsHasError extends IsLoaded {
  PortException? getError();
}

abstract class IsLoaded {
  bool loaded();
}
