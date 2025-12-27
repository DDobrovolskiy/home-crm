import 'package:get_it/get_it.dart';

import '../../../support/components/load/custom_load.dart';
import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../aggregate/role_aggregate.dart';
import '../repository/role_repository.dart';

class RoleStore extends Store<RoleAggregate> {
  late final RoleRepository _roleRepository = GetIt.I.get<RoleRepository>();

  LoadStore<RoleAggregate?> get(int id) {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad))[id],
      callback: loadCallback,
      refreshSource: () => refreshOnId(id),
    );
  }

  LoadStore<List<RoleAggregate>> getAll() {
    return LoadStore(
      value: () async => (await refresh(
        Loaded.ifNotLoad,
      )).entries.map((e) => e.value).toList(),
      callback: loadCallback,
      refreshSource: () {},
    );
  }

  @override
  Future<void> loadData() async {
    (await _roleRepository.roles())?.forEach((s) => data[s.id!] = s);
  }

  @override
  Future<RoleAggregate?> loadDataId(int id) {
    // TODO: implement loadDataIds
    throw UnimplementedError();
  }
}
