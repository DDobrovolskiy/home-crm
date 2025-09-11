import 'package:home_crm_front/domain/sub/scope/dto/response/scope_dto.dart';

import '../../../support/port/port.dart';

class ScopeRepository {
  final String _path = 'scope';

  Future<List<ScopeDTO>?> scopes() {
    return Port.get(
      _path,
      (j) =>
          (j as List)
              .map((i) => ScopeDTO.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
