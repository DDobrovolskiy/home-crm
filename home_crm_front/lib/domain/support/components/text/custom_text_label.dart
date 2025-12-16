import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class CustomLabelCircleText extends StatelessWidget {
  final Text text;
  final int? number;

  const CustomLabelCircleText({super.key, required this.text, this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, // Прижимаем всё к верху
      children: [
        Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 0, 3, 0), child: text),
        if (number != null)
          Transform.translate(
            offset: const Offset(0, -5), // Точная корректировка по вертикали
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: number == 0
                    ? CustomColors.getSecondaryText(context)
                    : CustomColors.getPrimary(context),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: CustomColors.getBodySmall(
                    context,
                    CustomColors.getPrimaryBtnText(context),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
