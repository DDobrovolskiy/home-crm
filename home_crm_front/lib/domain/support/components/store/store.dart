import 'dart:async';

import 'package:collection/collection.dart';
import 'package:home_crm_front/domain/support/components/aggregate/aggregate.dart';
import 'package:home_crm_front/domain/support/components/logger/custom_logger.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart';

import '../../exceptions/exceptions.dart';
import '../../port/port.dart';
import '../../service/loaded.dart';
import '../load/custom_load.dart';

abstract class Store<T extends Loader> extends IsHasError {
  bool load = false;
  PortException? error;
  LoadCallback loadCallback = LoadCallback();
  late Map<int, T> data = {};
  final _lock = Lock();
  bool _isRefreshing = false;
  Timer? _batchTimer;
  Set<int> _pendingIds = {};
  Completer<Map<int, T>>? _batchCompleter;

  bool get isRefreshing => _isRefreshing;

  Future<Map<int, T>> refresh(Loaded loaded) async {
    // 1. Быстрая проверка вне блокировки (Fast Exit)
    // Если загрузка не требуется согласно логике Loaded, выходим мгновенно
    if (!loaded.needLoad(this)) {
      return data;
    }
    final logBuffer = CustomLogger.buffer();
    logBuffer.add('refresh - ${loaded.name}');
    return await _lock.synchronized(() async {
      // Повторная проверка внутри блокировки (на случай, если
      // другой поток уже завершил загрузку, пока мы ждали очередь)
      if (!loaded.needLoad(this)) {
        logBuffer.print(Level.debug,
            message: 'другой поток уже завершил загрузку, пока мы ждали очередь');
        return data;
      }

        try {
          _isRefreshing = true;
          data.clear();

          // Уведомляем UI, что данных теперь нет и включился режим рефреша
          // Это заставит список отобразить скелетоны
          loadCallback.call();

          logBuffer.add(
              '${toString()}: loadData - refresh started (${loaded.name})');

          await loadData();

          load = true;
          error = null; // Сбрасываем старые ошибки при успешном старте
        } catch (e, stack) {
          logBuffer.print(
              Level.error, message: '${toString()}: Error during refresh',
              error: e,
              stackTrace: stack);
          error = Port.errorHandler(e);
        } finally {
          _isRefreshing = false;
          // Финальное уведомление UI (либо данные пришли, либо показываем ошибку)
          if (loaded != Loaded.ifNotLoad) {
            loadCallback.call();
          }
        }
      logBuffer.print(Level.debug);
      return data;
    });
  }

  Future<Map<int, T>> refreshOnIds(Set<int?> ids) async {
    final cleanIds = ids.nonNulls.toSet();
    if (cleanIds.isEmpty) return data;

    final logBuffer = CustomLogger.buffer();
    logBuffer.add(
        '${toString()}: Запрос на обновление refreshOnIds IDs: $cleanIds');

    if (!load) {
      logBuffer.print(Level.debug, message: 'ifNotLoad');
      return refresh(Loaded.ifNotLoad);
    }
    // 1. Добавляем ID в общий буфер ожидания
    _pendingIds.addAll(cleanIds);

    // 2. Если уже есть активный Completer, возвращаем его Future
    if (_batchCompleter != null && !(_batchCompleter!.isCompleted)) {
      logBuffer.print(Level.debug,
          message: 'уже есть активный Completer, возвращаем его Future');
      return _batchCompleter!.future;
    }

    // 3. Создаем новый Completer для текущей пачки
    _batchCompleter = Completer<Map<int, T>>();

    // 4. Запускаем короткий таймер для сбора "соседних" вызовов
    _batchTimer?.cancel();
    _batchTimer = Timer(const Duration(milliseconds: 500), () async {
      final idsToProcess = Set<int>.from(_pendingIds);
      _pendingIds.clear();

      // Передаем управление в основной метод обработки
      final result = await _executeBatchRefresh(idsToProcess);
      _batchCompleter?.complete(result);
    });
    logBuffer.print(Level.debug, message: 'batchCompleted');
    return _batchCompleter!.future;
  }

  Future<Map<int, T>> _executeBatchRefresh(Set<int> ids) async {
    return await _lock.synchronized(() async {
      final logBuffer = CustomLogger.buffer();
      logBuffer.add(
          'Batch ${toString()} Refresh started for ${ids.length} items');
      try {
        // Сохраняем старые значения для сравнения (Deep Equality)
        List<T> oldValues = [];
        for (var id in ids) {
          var oldValue = data[id];
          if (oldValue != null) {
            oldValues.add(oldValue);
          }
        }
        logBuffer.add('Запрос данных из API для ID: $ids');
        final List<T>? newValues = await loadDataIds(ids);

        if (newValues != null) {
          logBuffer.add('Получено новых значений: ${newValues.length}');
          // Проверка на изменения для вызова колбэка
          const equality = DeepCollectionEquality
              .unordered(); // Используем неупорядоченное сравнение
          if (!equality.equals(oldValues, newValues)) {
            logBuffer.add('Обнаружены изменения, уведомляем UI...');
            // Массовое обновление локальной карты
            var newMap = { for (var v in newValues) v.id: v};
            for (var id in ids) {
              var newValue = newMap[id];
              if (newValue == null) {
                data.remove(id);
              } else {
                data[id] = newValue;
              }
            }
            loadCallback.call();
          } else {
            logBuffer.add('Изменений не обнаружено.');
          }
        }
        logBuffer.print(Level.info);
      } catch (e, stack) {
        logBuffer.print(
            Level.error, message: '❌ Ошибка при пакетном обновлении',
            error: e,
            stackTrace: stack);
        error = Port.errorHandler(e);
      }
      return data;
    });
  }

  Future<void> loadData();

  Future<List<T>?> loadDataIds(Set<int> ids);

  LoadStore<T?> get(int id, Function() refreshSamSelf) {
    return LoadStore(
      value: () async {
        final logBuffer = CustomLogger.buffer();
        logBuffer.add('${toString()}: получение данных по ID get ${id}');
        Set<int> idsNull = {};
        var result = await Stream.value(await refresh(Loaded.ifNotLoad))
            .map((map) {
          var v = map[id];
          if (v == null) {
            idsNull.add(id);
          }
          return v;
        }).first;
        if (idsNull.isNotEmpty) {
          refreshSamSelf();
          refreshOnIds(idsNull);
          logBuffer.add(
              'Найдены нулевые IDs ${idsNull} - отправлены уведомления');
        }
        logBuffer.print(Level.debug);
        return result;
      },
      callback: loadCallback,
    );
  }

  LoadStore<Set<T?>> gets(Set<int> ids, Function() refreshSamSelf) {
    return LoadStore(
      value: () async {
        Set<int> idsNull = {};
        final logBuffer = CustomLogger.buffer();
        logBuffer.add('${toString()}: получение данных для IDs gets ${ids}');
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
          logBuffer.add(
              'Найдены нулевые IDs ${idsNull} - отправлены уведомления');
        }
        logBuffer.print(Level.debug);
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

  Future<void> delete(Set<int> ids) async {
    var deleteIds = Set<int>.from(ids);
    final logBuffer = CustomLogger.buffer();
    logBuffer.add('${toString()} delete ${deleteIds.length} items');
    for (var id in deleteIds) {
      data[id]?.load = true;
    }
    logBuffer.add('Aggregate`s установлены в load = true: $deleteIds');
    loadCallback.call();
    logBuffer.add('LoadCallback: $deleteIds');
    try {
      await deleteInBackend(deleteIds);
      logBuffer.add('deleteInBackend $deleteIds');
    } catch (e, stack) {
      logBuffer.print(Level.error, message: '❌ Ошибка при delete',
          error: e,
          stackTrace: stack);
      error = Port.errorHandler(e);
    }
    await refreshOnIds(deleteIds);
    logBuffer.add('refreshOnIds $deleteIds');
    logBuffer.print(Level.info);
  }

  Future<bool?> deleteInBackend(Set<int> ids);

  void execute(StoreCommand command) {
    command.execute(this);
  }

}

enum StoreEvent {
  UPDATE,
  DELETE
}

class StoreCommand<T extends Loader> {
  final Function(Store<T> store) execute;

  StoreCommand({required this.execute});
}
