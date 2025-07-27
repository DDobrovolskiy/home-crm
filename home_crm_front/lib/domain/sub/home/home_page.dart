import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../support/redux/state/app_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel(
        username: store.state.username,
        isLoggedIn: store.state.isLoggedIn,
        onLogout: () => store.dispatch({'type': "test"}),
      ),
      builder: (context, viewModel) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Text("HomePage"),
                Text(viewModel.username),
                if (viewModel.isLoggedIn)
                  ElevatedButton(
                    onPressed: viewModel.onLogout,
                    child: Text('Выйти'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ViewModel {
  final String username;
  final bool isLoggedIn;
  final VoidCallback onLogout;

  ViewModel({
    required this.username,
    required this.isLoggedIn,
    required this.onLogout,
  });
}
