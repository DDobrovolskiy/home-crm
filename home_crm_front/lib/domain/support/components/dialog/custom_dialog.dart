import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../screen/Screen.dart';

class CustomDialog {
  static Future<T> showDialog<T>(Widget child, BuildContext context) async {
    return await showAdaptiveDialog(
      context: context,
      barrierDismissible: false, // Окно не закрывается при нажатии вне области
      builder: (context) {
        return Dialog(
          backgroundColor: CustomColors.getSecondaryBackground(context),
          insetPadding: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(width: Screen.getMaxWidth(), child: child),
          ),
        );
      },
    );
  }
}
