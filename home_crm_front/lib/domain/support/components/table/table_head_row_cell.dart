import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../screen/Screen.dart';

class CustomTableHeadRowCell extends StatelessWidget {
  final String text;
  final bool textVisibleAlways;
  final String? subText;
  final bool subTextVisibleAlways;
  final int flex;

  const CustomTableHeadRowCell({
    super.key,
    required this.text,
    this.textVisibleAlways = false,
    this.subText,
    this.subTextVisibleAlways = false,
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: CustomColors.getLabelMedium(context, null)),
          if (subText != null && !flag && !subTextVisibleAlways)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
              child: Text(
                subText!,
                style: CustomColors.getLabelSmall(context, null),
              ),
            ),
        ],
      ),
    );
  }
}
