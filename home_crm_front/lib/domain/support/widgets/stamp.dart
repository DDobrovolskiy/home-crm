import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/authentication/event/auth_event.dart';
import 'package:home_crm_front/domain/support/router/roters.dart';

import '../../../home_crm_app.dart';
import '../../sub/authentication/bloc/auth_bloc.dart';
import '../../sub/user/bloc/user_bloc.dart';
import '../../sub/user/user_state/user_state.dart';
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

  static void showTemporarySnackbar(BuildContext? context, String message) {
    ScaffoldMessenger.of(
      context ?? GetIt.instance.get<AppRouter>().navigatorKey.currentContext!,
    ).showSnackBar(SnackBar(content: Text(message)));
    Timer(Duration(seconds: 5), () {
      ScaffoldMessenger.of(
        context ?? GetIt.instance.get<AppRouter>().navigatorKey.currentContext!,
      ).hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
    });
  }

  static Widget buttonMenuMain(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.menu), // Трехполосочная иконка
          onPressed: () => Scaffold.of(context).openDrawer(), // Открытие меню
        );
      },
    );
  }

  static Widget menuMain(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home), // Иконка выхода
              title: Text('Домашняя страница'),
              onTap: () {
                AutoRouter.of(context).push(HomeRoute());
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.business),
              // Иконка домашней страницы
              title: Text('Организация'),
              initiallyExpanded: false,
              // Начальное состояние свернуто
              childrenPadding: EdgeInsets.all(16),
              // Внутренние отступы для развернутого меню
              children: [
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Сотрудники'),
                  onTap: () {
                    AutoRouter.of(context).push(OrganizationEmployeesRoute());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text('Роли'),
                  onTap: () {
                    AutoRouter.of(context).push(OrganizationRolesRoute());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('Обучение'),
                  onTap: () {
                    // AutoRouter.of(context).push(HelpRoute());
                  },
                ),
              ],
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.face),
              title: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadedState) {
                    return Text(state.user!.name);
                  } else {
                    return Stamp.loadWidget(context);
                  }
                },
              ),
              onTap: () {
                AutoRouter.of(context).push(UserRoute());
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget buttonMenuSupplier(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.menu_open_outlined), // Трехполосочная иконка
          onPressed: () =>
              Scaffold.of(context).openEndDrawer(), // Открытие меню
        );
      },
    );
  }

  static Widget menuSupplier(BuildContext context) {
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
              onTap: () async {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                var bool = await resetBlocs();
                AutoRouter.of(context).replace(LoginRoute());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app), // Иконка выхода
              title: Text('Выйти со всех устройств'),
              onTap: () async {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutAllEvent());
                var bool = await resetBlocs();
                AutoRouter.of(context).replace(LoginRoute());
              },
            ),
          ],
        ),
      ),
    );
  }

  static ButtonStyle giperLink() {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return Colors.blue; // Устанавливаем синий цвет текста
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.pressed)
            ? Colors.blue.withOpacity(0.1) // Цвет фона при нажатии
            : Colors.transparent;
      }),
      textStyle: WidgetStateProperty.resolveWith((states) {
        return TextStyle(
          decoration: TextDecoration.underline,
        ); // Подчёркивание текста
      }),
    );
  }

  static Widget giperLinkText(Widget text, VoidCallback? onPressed) {
    return TextButton(
      style: Stamp.giperLink(),
      onPressed: onPressed,
      child: text,
    );
  }
}
