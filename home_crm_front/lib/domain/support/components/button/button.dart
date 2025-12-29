import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../screen/Screen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool primary;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(16.0)),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: primary
                ? CustomColors.getPrimary(context)
                : CustomColors.getLineColor(context),
            width: 2,
          ),
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
          primary
              ? CustomColors.getPrimary(context)
              : CustomColors.getPrimaryBackground(context),
        ),
      ),
      child: Text(
        text,
        style: CustomColors.getBodyLarge(
          context,
          primary ? CustomColors.getPrimaryBtnText(context) : null,
        ),
      ),
    );
  }
}

class CustomButtonDisplay extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool primary;

  const CustomButtonDisplay({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(16.0)),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: primary
                ? (onPressed != null) ? CustomColors.getPrimary(context) : CustomColors.getSecondaryText(context)
                : (onPressed != null) ? CustomColors.getLineColor(context) : CustomColors.getSecondaryText(context),
            width: 2,
          ),
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
          primary
              ? (onPressed != null) ? CustomColors.getPrimary(context) : CustomColors.getSecondaryText(context).withAlpha(100)
              : (onPressed != null) ? CustomColors.getPrimaryBackground(context) : CustomColors.getSecondaryText(context).withAlpha(100),
        ),
      ),
      child: Column(children: [
        Text(
          text,
          style: Screen.isWeb(context)
              ? CustomColors.getDisplaySmallButtonIsWeb(
            context,
            primary ? CustomColors.getPrimaryBtnText(context) : null,
          )
              : CustomColors.getDisplaySmallButton(
            context,
            primary ? CustomColors.getPrimaryBtnText(context) : null,
          ),
        ),
      ],),
    );
  }
}
