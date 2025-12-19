import '../../../support/port/port.dart';
import '../aggregate/scope_aggregate.dart';

class ScopeRepository {
  final String _path = 'scope';

  Future<List<ScopeAggregate>?> scopes() {
    return Port.get(
      _path,
      (j) =>
          (j as List)
              .map((i) => ScopeAggregate.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
