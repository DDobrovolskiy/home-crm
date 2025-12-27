import 'package:get_it/get_it.dart';

import '../../../support/components/load/custom_load.dart';
import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../aggregate/scope_aggregate.dart';
import '../repository/scope_repository.dart';

class ScopeStore extends Store<ScopeAggregate> {
  late final ScopeRepository _scopeRepository = GetIt.I.get<ScopeRepository>();

  LoadStore<ScopeAggregate?> get(int id) {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad))[id],
      callback: loadCallback,
      refreshSource: () => refreshOnId(id),
    );
  }

  @override
  Future<void> loadData() async {
    (await _scopeRepository.scopes())?.forEach((s) => data[s.id!] = s);
  }

  LoadStore<Set<ScopeAggregate>> gets(Set<int> ids) {
    return LoadStore(
      value: () async => (await refresh(
        Loaded.ifNotLoad,
      )).entries.where((e) => ids.contains(e.key)).map((e) => e.value).toSet(),
      callback: loadCallback,
      refreshSource: () {},
    );
  }

  @override
  Future<ScopeAggregate?> loadDataId(int id) {
    // TODO: implement loadDataIds
    throw UnimplementedError();
  }
}
