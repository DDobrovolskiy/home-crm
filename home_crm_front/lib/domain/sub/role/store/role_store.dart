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
    );
  }

  @override
  Future<Map<int, RoleAggregate>> loadData() async {
    return {
      for (var item in ((await _roleRepository.roles()) ?? [])) item.id: item,
    };
  }
}
