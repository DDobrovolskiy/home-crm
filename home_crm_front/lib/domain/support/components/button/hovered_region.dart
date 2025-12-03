import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class HoveredRegion extends StatefulWidget {
  final VoidCallback onTap;
  final Widget Function(bool isHovered) child;

  const HoveredRegion({super.key, required this.onTap, required this.child});

  @override
  _HoveredRegionState createState() => _HoveredRegionState();
}

class _HoveredRegionState extends State<HoveredRegion> {
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
          child: widget.child(isHovered),
        ),
      ),
    );
  }
}
