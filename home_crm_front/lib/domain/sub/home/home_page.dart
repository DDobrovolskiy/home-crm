import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, viewModel) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Text("HomePage"),
              ],
            ),
          ),
        );
      },
    );
  }
}
