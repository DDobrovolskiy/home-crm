import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import '../../../sub/authentication/action/registration_success_action.dart';
import '../../../sub/authentication/middleware/registration_middleware.dart';
import '../../../sub/authentication/reducer/registration_reducer.dart';
import '../state/app_state.dart';

Store<AppState> createStore(AppState appState) {
  return Store<AppState>(
    combineReducers<AppState>([
      TypedReducer<AppState, RegistartionSuccesAction>(registrationReducer),
    ]),
    initialState: appState,
    middleware: [
      NavigationMiddleware<AppState>(),
      RegistrationMiddleware(),
    ],
  );
}
