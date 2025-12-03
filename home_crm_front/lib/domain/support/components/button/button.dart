import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
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
        child: Text(text, style: CustomColors.getTitleSmall(context, null)),
      ),
    );
  }
}
