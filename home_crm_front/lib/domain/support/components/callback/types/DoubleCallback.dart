class DoubleCallback<K, V> {
  List<Function(K, V)> subscribers = [];

  void subscribe(Function(K, V) func) {
    subscribers.add(func);
  }

  void call(K key, V value) {
    for (var s in subscribers) {
      s(key, value);
    }
  }
}
