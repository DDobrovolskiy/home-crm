import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("HomePage"),
            TextButton(
              onPressed: () {
                // store.dispatch(LogoutAction());
              },
              child: Text(
                'Выйти',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                // store.dispatch(LogoutAllAction());
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
  }
}
