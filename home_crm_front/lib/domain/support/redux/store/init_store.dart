import 'package:flutter/src/widgets/framework.dart';
import 'package:home_crm_front/domain/support/redux/middleware/middleware.dart';
import 'package:home_crm_front/domain/support/redux/reducer/app_reducer.dart';
import 'package:redux/redux.dart';

import '../state/app_state.dart';

Store<AppState> createStore(String? authToken, BuildContext context) {
  return Store<AppState>(
    appRepucer,
    initialState: AppState(
      username: 'TestUser',
      isLoggedIn: authToken != null,
      authToken: authToken,
    ),
    middleware: createMiddleware(context),
  );
}
