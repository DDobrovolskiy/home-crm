import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.all(16.0)),
          side: WidgetStatePropertyAll(
            BorderSide(color: CustomColors.getLineColor(context), width: 2),
          ),
          // Толщина и цвет границы
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ), // закругление углов
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            CustomColors.getPrimaryBackground(context),
          ),
        ),
      child: Text(text, style: CustomColors.getBodyLarge(context, null)),
    );
  }
}
