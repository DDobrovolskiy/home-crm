import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/sub/user/store/user_state.dart';
import 'package:redux/redux.dart';

import '../../../support/port/port.dart';
import '../../../support/redux/state/app_state.dart';
import '../../../support/router/roters.dart';
import '../../user/dto/user_dto.dart';
import '../actions/user_actions.dart';

class UserMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetInfoUserAction) {
      Port.get(
        'user',
        store,
        (j) => UserDto.fromJson(j as Map<String, dynamic>),
        (user) {
          if (store.state.userState == null ||
              store.state.userState?.chooseOrganizationId == 0) {
            //надо выбрать организацию
            store.state.userState = UserState.from(user!);
            store.dispatch(NavigateToAction.replace(RoutersApp.user));
          } else {
            //просто обновляем данные
            var from = UserState.from(user!);
            from.chooseOrganizationId =
                store.state.userState!.chooseOrganizationId;
            store.state.userState = from;
          }
        },
      );
    } else if (action is RefreshInfoUserAction) {
      Port.get(
        'user',
        store,
        (j) => UserDto.fromJson(j as Map<String, dynamic>),
        (user) {
          store.state.userState = UserState.from(user!);
          store.dispatch(NavigateToAction.replace(RoutersApp.user));
        },
      );
    } else {
      next(action);
    }
  }
}
