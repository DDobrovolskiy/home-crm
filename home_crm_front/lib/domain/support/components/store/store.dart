import 'package:home_crm_front/domain/support/components/aggregate/aggregate.dart';
import 'package:synchronized/synchronized.dart';

import '../../exceptions/exceptions.dart';
import '../../port/port.dart';
import '../../service/loaded.dart';
import '../load/custom_load.dart';

abstract class Store<T extends Id> extends IsHasError {
  bool load = false;
  PortException? error;
  LoadCallback loadCallback = LoadCallback();
  late Map<int, T> data = {};
  final _lock = Lock();

  Future<Map<int, T>> refresh(Loaded loaded) async {
    return await _lock.synchronized(() async {
      if (loaded.needLoad(this)) {
        try {
          data.clear();
          await loadData();
          load = true;
          if (loaded != Loaded.ifNotLoad) {
            loadCallback.call();
          }
        } catch (e) {
          error = Port.errorHandler(e);
        }
      }
      return data;
    });
  }

  Future<Map<int, T>> refreshOnId(int id) async {
    if (load) {
      return await _lock.synchronized(() async {
        try {
          T? t1 = data.remove(id);
          T? t2 = await loadDataId(id);
          if (t2 != null) {
            data[t2.id!] = t2;
          }
          if (t1?.getKey() != t2?.getKey()) {
            loadCallback.call();
          }
        } catch (e) {
          error = Port.errorHandler(e);
        }
        return data;
      });
    } else {
      return refresh(Loaded.ifNotLoad);
    }
  }

  Future<void> loadData();

  Future<T?> loadDataId(int id);

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return load;
  }
}
