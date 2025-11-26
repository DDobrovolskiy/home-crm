import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class NavSubElement extends StatefulWidget {
  final String label;
  final VoidCallback onTap; // Коллбэк, вызываемый при нажатии

  const NavSubElement({Key? key, required this.label, required this.onTap})
    : super(key: key);

  @override
  _NavSubElementState createState() => _NavSubElementState();
}

class _NavSubElementState extends State<NavSubElement> {
  bool isHovered = false;

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
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isHovered
                    ? CustomColors.getPrimaryBackground(context)
                    : CustomColors.getSecondaryBackground(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 28, height: 28),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
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
