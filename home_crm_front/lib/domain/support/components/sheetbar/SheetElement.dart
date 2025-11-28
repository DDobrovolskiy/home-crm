import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../callback/NavBarCallBack.dart';

class SheetElement extends StatefulWidget {
  final String label;
  final bool isSelected;

  const SheetElement({
    super.key,
    required this.isSelected,
    required this.label,
  });

  @override
  _SheetElementState createState() => _SheetElementState();
}

class _SheetElementState extends State<SheetElement> {
  bool isHovered = false;

  Color getColor() {
    if (isHovered) {
      if (widget.isSelected) {
        return CustomColors.getPrimary(context).withAlpha(700);
      }
      return CustomColors.getSecondaryText(context).withAlpha(300);
    } else {
      if (widget.isSelected) {
        return CustomColors.getPrimary(context);
      }
      return CustomColors.getSecondaryText(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Material(
        color: CustomColors.getPrimaryBackground(context),
        child: InkWell(
          highlightColor: Colors.transparent,
          // Подсветка при нажатии
          splashColor: Colors.transparent,
          // Splash-эффект при касании
          focusColor: Colors.transparent,
          // Цвет фокусировки
          hoverColor: Colors.transparent,
          // Подсветка при наведении
          onTap: () {
            GetIt.I.get<SheetElementSelectCallback>().call(widget.label);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 0),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: getColor(),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x34090F13),
                    offset: Offset(0.0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: getColor(), width: 1),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 6, 6, 6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: CustomColors.getTitleMedium(context, Colors.white),
                    ),
                    if (isHovered)
                      IconButton(
                        onPressed: () {
                          GetIt.I.get<SheetElementDeleteCallback>().call(
                            widget.label,
                          );
                        },
                        splashRadius: 3,
                        icon: Icon(Icons.close, size: 12),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
