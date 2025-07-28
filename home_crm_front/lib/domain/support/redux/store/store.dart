import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import '../state/app_state.dart';

Store<AppState> createStore(AppState appState) {
  return Store<AppState>(
    combineReducers<AppState>([
    ]),
    initialState: appState,
    middleware: [
      NavigationMiddleware<AppState>(),
    ],
  );
}
