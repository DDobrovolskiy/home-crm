import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/authentication/event/auth_event.dart';

import '../../../home_crm_app.dart';
import '../../sub/authentication/bloc/auth_bloc.dart';
import '../router/roters.gr.dart';

class Stamp {
  static Widget errorWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(), // Обычный круг прогрессии
        const Padding(padding: EdgeInsets.all(16)),
        Text(
          'Что-то пошло не так...',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  static Widget authErrorWidget(BuildContext context) {
    AutoRouter.of(context).push(LoginRoute());
    return Text('Пользователь не авторизован');
  }

  static Widget loadWidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(), // Стандартное кольцо загрузки
    );
  }

  static void showTemporarySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    Timer(Duration(seconds: 5), () {
      ScaffoldMessenger.of(
        context,
      ).hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
    });
  }

  static Widget buttonMenu(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.menu), // Трехполосочная иконка
          onPressed: () =>
              Scaffold.of(context).openEndDrawer(), // Открытие меню
        );
      },
    );
  }

  static Widget menu(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.account_box), // Иконка выхода
              title: Text('Личный кабинет'),
              onTap: () {
                AutoRouter.of(context).push(UserRoute());
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.exit_to_app), // Иконка выхода
              title: Text('Выйти'),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                resetBlocs();
                AutoRouter.of(context).replace(LoginRoute());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app), // Иконка выхода
              title: Text('Выйти со всех устройств'),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutAllEvent());
                resetBlocs();
                AutoRouter.of(context).replace(LoginRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
