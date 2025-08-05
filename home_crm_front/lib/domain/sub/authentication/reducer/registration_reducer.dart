import 'package:home_crm_front/domain/support/redux/state/app_state.dart';

import '../action/registration_success_action.dart';

AppState registrationReducer(AppState appState,
    RegistartionSuccesAction action) {
  if (action.token != null) {
    return AppState(action.token);
  }
  return appState;
}