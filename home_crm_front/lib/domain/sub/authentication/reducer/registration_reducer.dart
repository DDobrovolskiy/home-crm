import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/authentication/action/registration_action.dart';
import 'package:home_crm_front/domain/support/redux/state/app_state.dart';

AppState registrationReducer(AppState appState, RegistrationAction action) {
  if (action.login != null && action.password != null) {
    return AppState('test');
  }
  return appState;
}