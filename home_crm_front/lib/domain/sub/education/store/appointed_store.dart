import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
import 'package:home_crm_front/domain/support/components/load/custom_load.dart';

import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../aggregate/appointed_aggregate.dart';

class AppointedStore extends Store<AppointedAggregate> {
  @override
  Future<Map<int, AppointedAggregate>> loadData() async {
    await Future.delayed(Duration(seconds: 1));
    GetIt.I
        .get<EducationStore>()
        .testList
        .expand((e) => e.appointed)
        .where((a) => a.employeeId == 1)
        .forEach((a) {
          data[a.id!] = a;
        });
    return data;
  }

  LoadStore<AppointedAggregate?> get(int id) {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad))[id],
      callback: loadCallback,
    );
  }

  LoadStore<List<AppointedAggregate>> getAll() {
    return LoadStore(
      value: () async => (await refresh(
        Loaded.ifNotLoad,
      )).entries.map((e) => e.value).toList(),
      callback: loadCallback,
    );
  }

  void save(List<AppointedAggregate> tests) {
    // tests.where((t) => t.id == null).forEach((t) => t.id = testList.length + 1);
    // testList.addAll(tests);
    refresh(Loaded.ifLoad);
  }
}
