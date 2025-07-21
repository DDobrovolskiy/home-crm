import 'package:flutter/material.dart';

class ShowDialog {
  void showErrorMessage(BuildContext context, String message) {
    // Функция вывода сообщения об ошибке
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}