import 'package:flutter/material.dart';

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
}
