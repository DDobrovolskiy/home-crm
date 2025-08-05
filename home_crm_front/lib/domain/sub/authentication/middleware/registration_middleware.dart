import 'package:redux/redux.dart';

import '../../../support/redux/state/app_state.dart';
import '../action/registration_action.dart';

class RegistrationMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegistrationAction) {
      // store.state.registration.load = true;
      await Future.delayed(Duration(seconds: 3));
      next(action);
      store.state.registration.load = false;
    }
  }

}
