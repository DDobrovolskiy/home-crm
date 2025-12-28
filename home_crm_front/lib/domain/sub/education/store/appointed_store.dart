import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
import 'package:home_crm_front/domain/support/components/load/custom_load.dart';

import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../aggregate/appointed_aggregate.dart';

class AppointedStore extends Store<AppointedAggregate> {
  @override
  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 1));
    //TODO
    GetIt.I
        .get<EducationStore>()
        .testList
        .expand((e) => e.appointed)
        .where((a) => a.employeeId == 1)
        .forEach((a) {
          print(a.id);
          data[a.id!] = a;
        });
    print(data);
  }

  @override
  Future<List<AppointedAggregate>?> loadDataIds(Set<int> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    await Future.delayed(Duration(seconds: 1));
    return GetIt.I
        .get<EducationStore>()
        .testList
        .expand((e) => e.appointed)
        .where((a) => a.employeeId == 1)
        .where((a) => ids.contains(a.id))
        .toList();
  }

  LoadStore<List<AppointedAggregate>> getAll({
    bool showDone = false,
    bool showNotActive = false,
  }) {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad)).entries
          .map((e) => e.value)
          .where(
            (a) =>
                (a.active == true || showNotActive) &&
                (!a.isDone() || showDone),
          )
          .toList(),
      callback: loadCallback,
    );
  }

  LoadStore<Map<int, AppointedAggregate>> getAllMap() {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad)),
      callback: loadCallback,
    );
  }

  void save(List<AppointedAggregate> tests) {
    // tests.where((t) => t.id == null).forEach((t) => t.id = testList.length + 1);
    // testList.addAll(tests);
    refresh(Loaded.ifLoad);
  }

  @override
  Future<bool?> deleteInBackend(Set<int> ids) {
    // TODO: implement deleteInBackend
    throw UnimplementedError();
  }
}
