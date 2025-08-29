import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
    Timer(Duration(seconds: 5), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(
          reason: SnackBarClosedReason.timeout);
    });
  }
}
