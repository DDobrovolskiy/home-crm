import 'package:collection/collection.dart';
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

  Future<Map<int, T>> refreshOnIds(Set<int?> ids) async {
    if (load) {
      return await _lock.synchronized(() async {
        try {
          List<T> oldValues = [];
          for (var id in ids) {
            var remove = data.remove(id);
            if (remove != null) {
              oldValues.add(remove);
            }
          }
          List<T>? newValues = await loadDataIds(ids.nonNulls.toSet());
          print('oldValues - $oldValues');
          print('newValues - $newValues');
          if (newValues != null) {
            for (var v in newValues) {
              data[v.id!] = v;
            }
          }
          const equality = DeepCollectionEquality();
          if (!equality.equals(oldValues, newValues)) {
            print('loadCallback');
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

  Future<List<T>?> loadDataIds(Set<int> ids);

  LoadStore<T?> get(int id, Function() refreshSamSelf) {
    return LoadStore(
      value: () async {
        print('get - $id');
        Set<int> idsNull = {};
        var result = await Stream.value(await refresh(Loaded.ifNotLoad))
            .map((map) {
          var v = map[id];
          if (v == null) {
            idsNull.add(id);
          }
          return v;
        }).first;
        print('get - ids - nulls - $idsNull');
        if (idsNull.isNotEmpty) {
          refreshSamSelf();
          refreshOnIds(idsNull);
        }
        return result;
      },
      callback: loadCallback,
    );
  }

  LoadStore<Set<T?>> gets(Set<int> ids, Function() refreshSamSelf) {
    return LoadStore(
      value: () async {
        Set<int> idsNull = {};
        var result = await Stream.value(await refresh(Loaded.ifNotLoad))
            .map((map) =>
            ids.map((id) {
              var v = map[id];
              if (v == null) {
                idsNull.add(id);
              }
              return v;
            }).toSet())
            .first;
        if (idsNull.isNotEmpty) {
          refreshSamSelf();
          refreshOnIds(idsNull);
        }
        return result;
      },
      callback: loadCallback,
    );
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return load;
  }
}
