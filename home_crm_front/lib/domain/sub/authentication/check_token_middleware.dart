import 'package:home_crm_front/domain/sub/authentication/auth_action.dart';
import 'package:home_crm_front/domain/support/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class CheckTokenMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {}
}
