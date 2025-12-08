import 'package:get_it/get_it.dart';

import '../../../support/service/loaded.dart';
import '../bloc/scope_bloc.dart';
import '../event/scope_event.dart';

class ScopeService {
  late final ScopeBloc _scopeBloc = GetIt.instance.get<ScopeBloc>();

  void refreshScopes(Loaded loaded) {
    if (loaded.needLoad(_scopeBloc.state)) {
      _scopeBloc.add(ScopeRefreshEvent());
    }
  }
}
