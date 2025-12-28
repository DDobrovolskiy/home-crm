import 'package:get_it/get_it.dart';

import '../../../support/components/store/store.dart';
import '../aggregate/scope_aggregate.dart';
import '../repository/scope_repository.dart';

class ScopeStore extends Store<ScopeAggregate> {
  late final ScopeRepository _scopeRepository = GetIt.I.get<ScopeRepository>();

  @override
  Future<void> loadData() async {
    (await _scopeRepository.scopes())?.forEach((s) => data[s.id!] = s);
  }

  @override
  Future<List<ScopeAggregate>?> loadDataIds(Set<int> ids) {
    // TODO: implement loadDataIds
    throw UnimplementedError();
  }

  @override
  Future<bool?> deleteInBackend(Set<int> ids) {
    // TODO: implement deleteInBackend
    throw UnimplementedError();
  }

  @override
  Future<List<ScopeAggregate>?> saveInBackend(List<ScopeAggregate> aggregates) {
    // TODO: implement saveInBackend
    throw UnimplementedError();
  }
}
