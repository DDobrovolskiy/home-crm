import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/support/router/roters.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';

Middleware<AppState> authenticationMiddleware(BuildContext context) {
  return (Store<AppState> store, action, NextDispatcher next) {
    debugPrint('authenticationMiddleware at timestamp: ${DateTime.now()}');
    if (store.state.isLoggedIn == false &&
        ModalRoute.of(context)?.settings.name != RoutersApp.registration) {
      Navigator.pushReplacementNamed(context, RoutersApp.registration);
    }
    next(action);
  };
}
