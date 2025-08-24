import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/sub/organization/middleware/organization_middleware.dart';
import 'package:redux/redux.dart';

import '../../../sub/authentication/action/login_success_action.dart';
import '../../../sub/authentication/action/logout_action.dart';
import '../../../sub/authentication/action/registration_success_action.dart';
import '../../../sub/authentication/middleware/auth_middleware.dart';
import '../../../sub/authentication/reducer/auth_reducer.dart';
import '../../../sub/user/middleware/user_middleware.dart';
import '../state/app_state.dart';

Store<AppState> createStore(AppState appState) {
  return Store<AppState>(
    combineReducers<AppState>([
      TypedReducer<AppState, RegistartionSuccesAction>(registrationReducer),
      TypedReducer<AppState, LoginSuccessAction>(loginReducer),
      TypedReducer<AppState, LogoutAction>(logoutReducer),
    ]),
    initialState: appState,
    middleware: [
      NavigationMiddleware<AppState>(),
      AuthMiddleware(),
      UserMiddleware(),
      OrganizationMiddleware(),
    ],
  );
}
