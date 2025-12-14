import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/support/components/button/button.dart';

import '../../../../theme/theme.dart';

class LabelPage extends StatelessWidget {
  final Function()? onAdd;
  final Function()? onRefresh;
  final Function()? onButton;
  final String? buttonText;
  final String text;

  const LabelPage({
    super.key,
    this.onAdd,
    this.onRefresh,
    this.onButton,
    this.buttonText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            primary: false,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (onAdd != null)
                    IconButton(
                      onPressed: onAdd,
                      color: CustomColors.getPrimary(context),
                      icon: Icon(Icons.add_circle, size: 44),
                    ),
                  if (onRefresh != null)
                    IconButton(
                      onPressed: onRefresh,
                      color: CustomColors.getPrimary(context),
                      icon: Icon(Icons.refresh_sharp, size: 44),
                    ),
                  if (onButton != null && buttonText != null)
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(0, 0, 24, 0),
                      child: CustomButtonDisplay(
                        primary: true,
                        text: 'Сохранить и закрыть',
                        onPressed: onButton!,
                      ),
                    ),
                  Text(
                    text,
                    textAlign: TextAlign.start,
                    style: CustomColors.getDisplaySmall(context, null),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
