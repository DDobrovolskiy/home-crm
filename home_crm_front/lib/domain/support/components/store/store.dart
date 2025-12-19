import 'package:synchronized/synchronized.dart';

import '../../exceptions/exceptions.dart';
import '../../port/port.dart';
import '../../service/loaded.dart';
import '../load/custom_load.dart';

abstract class Store<T> extends IsHasError {
  bool load = false;
  PortException? error;
  LoadCallback loadCallback = LoadCallback();
  late Map<int, T> data = {};
  final _lock = Lock();

  Future<Map<int, T>> refresh(Loaded loaded) async {
    return await _lock.synchronized(() async {
      if (loaded.needLoad(this)) {
        try {
          load = true;
          data = await loadData();
          if (loaded != Loaded.ifNotLoad) {
            loadCallback.call();
          }
        } catch (e) {
          print(e.toString());
          error = Port.errorHandler(e);
        }
      }
      return data;
    });
  }

  Future<Map<int, T>> loadData();

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return load;
  }
}
