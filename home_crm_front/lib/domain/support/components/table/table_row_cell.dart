import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../screen/Screen.dart';

class CustomTableRowCell extends StatelessWidget {
  final String text;
  final bool textVisibleAlways;
  final String? subText;
  final bool subTextVisibleAlways;
  final Widget? icon;
  final int flex;

  const CustomTableRowCell({
    super.key,
    required this.text,
    this.textVisibleAlways = false,
    this.subText,
    this.subTextVisibleAlways = false,
    this.icon,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    bool flag = Screen.isWeb(context);
    if (!flag && !textVisibleAlways) {
      return SizedBox();
    }
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: icon,
            ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: CustomColors.getBodyLarge(context, null)),
                if (subText != null && !flag && !subTextVisibleAlways)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Text(
                      subText!,
                      style: CustomColors.getLabelMedium(context, null),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
