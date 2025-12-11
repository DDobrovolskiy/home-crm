import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../screen/Screen.dart';

class CustomTableRowCellText extends StatelessWidget {
  final String text;
  final bool textVisibleAlways;
  final String? subText;
  final bool subTextVisibleAlways;
  final Widget? icon;
  final int flex;

  const CustomTableRowCellText({
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

class CustomTableRowCell extends StatelessWidget {
  final Widget body;
  final bool textVisibleAlways;
  final int flex;

  const CustomTableRowCell({
    super.key,
    required this.body,
    this.textVisibleAlways = false,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    bool flag = Screen.isWeb(context);
    if (!flag && !textVisibleAlways) {
      return SizedBox();
    }
    return Expanded(flex: flex, child: body);
  }
}

class CustomTableRowCellMinimal extends StatelessWidget {
  final Widget body;
  final bool textVisibleAlways;
  final int flex;

  const CustomTableRowCellMinimal({
    super.key,
    required this.body,
    this.textVisibleAlways = false,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    bool flag = Screen.isWeb(context);
    if (!flag && !textVisibleAlways) {
      return SizedBox();
    }
    return Flexible(flex: flex, child: body);
  }
}

class CustomTableRowCellPopupMenu extends StatelessWidget {
  final PopupMenuItemSelected<String> onSelected;
  final bool textVisibleAlways;
  final int flex;
  final bool editVisible;
  final bool deleteVisible;

  const CustomTableRowCellPopupMenu({
    super.key,
    this.textVisibleAlways = false,
    this.flex = 1,
    required this.onSelected,
    this.editVisible = true,
    this.deleteVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    bool flag = Screen.isWeb(context);
    if (!flag && !textVisibleAlways) {
      return SizedBox();
    }
    return Expanded(
      flex: flex,
      child: PopupMenuButton<String>(
        color: CustomColors.getSecondaryBackground(context),
        icon: Icon(Icons.more_horiz), // Три точки
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            if (editVisible)
              PopupMenuItem<String>(
                value: 'Edit',
                child: Text(
                  'Редактировать',
                  style: CustomColors.getBodyMedium(context, null),
                ),
              ),
            if (deleteVisible)
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text(
                  'Удалить',
                  style: CustomColors.getBodyMedium(context, null),
                ),
              ),
          ];
        },
      ),
    );
  }
}
