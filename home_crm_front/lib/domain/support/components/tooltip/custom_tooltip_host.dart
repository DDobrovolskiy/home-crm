import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class CustomTooltipHost extends StatefulWidget {
  final Text child;
  final Widget Function(Function()) tooltipContent;

  const CustomTooltipHost({
    Key? key,
    required this.child,
    required this.tooltipContent,
  }) : super(key: key);

  @override
  _CustomTooltipHostState createState() => _CustomTooltipHostState();
}

class _CustomTooltipHostState extends State<CustomTooltipHost> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _widgetKey = GlobalKey();

  void _showOverlay() {
    // Расчет позиции виджета (как и раньше)
    final RenderBox renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        // Используем Stack, чтобы разместить барьер и подсказку друг над другом
        children: [
          // *** Элемент 1: Невидимый барьер, реагирующий на тапы ***
          Positioned.fill(
            // Positioned.fill занимает все доступное пространство Overlay
            child: GestureDetector(
              onTap: _hideOverlay, // При тапе на барьер вызываем закрытие
              child: Container(
                // Container может быть пустым, но он ловит тапы
                // Можно добавить легкую прозрачную заливку для отладки: color: Colors.black.withOpacity(0.1),
                color: Colors.transparent,
              ),
            ),
          ),

          // *** Элемент 2: Сама подсказка, позиционированная точно ***
          Positioned(
            left: position.dx,
            top: position.dy + size.height + 5.0,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8.0),
              color: CustomColors.getSecondaryBackground(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.tooltipContent(() {
                  _hideOverlay();
                }),
              ),
            ),
          ),
        ],
      ),
    );

    // Вставляем OverlayEntry в ближайший OverlayState
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Оригинальный виджет, который вызывает показ подсказки по тапу
    return GestureDetector(
      key: _widgetKey,
      onTap: _overlayEntry == null ? _showOverlay : _hideOverlay,
      child: Text(
        widget.child.data ?? '',
        style: widget.child.style?.copyWith(
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dotted,
          decorationThickness: 1.5,
        ),
      ),
    );
  }
}
