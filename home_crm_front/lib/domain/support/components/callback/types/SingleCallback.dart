class SingleCallback<T> {
  List<Function(T)> subscribers = [];

  void subscribe(Function(T) func) {
    subscribers.add(func);
  }

  void call(T value) {
    for (var s in subscribers) {
      s(value);
    }
  }
}
