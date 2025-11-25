import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class NavElement extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSelected; // Индекс элемента в списке
  final VoidCallback onTap; // Коллбэк, вызываемый при нажатии

  const NavElement({
    Key? key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _NavElementState createState() => _NavElementState();
}

class _NavElementState extends State<NavElement> {
  bool isHovered = false;

  Color getColorIcon() {
    if (isHovered) {
      return CustomColors.getPrimaryText(context);
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
        color: CustomColors.getSecondaryBackground(context),
        child: InkWell(
          highlightColor: Colors.transparent,
          // Подсветка при нажатии
          splashColor: Colors.transparent,
          // Splash-эффект при касании
          focusColor: Colors.transparent,
          // Цвет фокусировки
          hoverColor: Colors.transparent,
          // Подсветка при наведении
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.isSelected || isHovered
                    ? CustomColors.getPrimaryBackground(context)
                    : CustomColors.getSecondaryBackground(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business_rounded,
                      color: getColorIcon(),
                      size: 28,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Text(
                        widget.label,
                        style: CustomColors.getBodyLarge(context, null),
                      ),
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
