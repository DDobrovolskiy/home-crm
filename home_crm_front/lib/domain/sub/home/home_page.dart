import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:home_crm_front/domain/sub/authentication/action/logout_action.dart';
import 'package:home_crm_front/domain/sub/authentication/action/logout_all_action.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Text("HomePage"),
                TextButton(
                  onPressed: () {
                    store.dispatch(LogoutAction());
                  },
                  child: Text(
                    'Выйти',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    store.dispatch(LogoutAllAction());
                  },
                  child: Text(
                    'Выйти на всех устройствах',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
