import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/components/content/ContentList.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../callback/NavBarCallBack.dart';
import '../screen/Screen.dart';
import 'SheetElement.dart';

class SheetBar extends StatefulWidget {
  const SheetBar({super.key});

  @override
  _SheetBarState createState() => _SheetBarState();
}

class _SheetBarState extends State<SheetBar> {
  final ScrollController _controller = ScrollController();
  final List<String> elements = [];
  String selected = '';

  _SheetBarState() {
    GetIt.I.get<SheetElementAddCallback>().subscribe((element, widget) {
      setState(() {
        selected = element;
        if (!elements.contains(element)) {
          elements.add(element);
        }
        var indexOf = elements.indexOf(element);
        scroll(indexOf * 250);
      });
    });
    GetIt.I.get<SheetElementSelectCallback>().subscribe((element) {
      setState(() {
        selected = element;
      });
    });
    GetIt.I.get<SheetElementDeleteCallback>().subscribe((element) {
      setState(() {
        elements.remove(element);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Уничтожаем контроллер при завершении
    super.dispose();
  }

  void scroll(double offset) {
    _controller.animateTo(
      offset, // Прокручиваемся на 100 пикселей вперёд
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  // Функция для прокрутки вперед
  void scrollForward() {
    _controller.animateTo(
      _controller.offset + 230, // Прокручиваемся на 100 пикселей вперёд
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  // Функция для прокрутки назад
  void scrollBackward() {
    _controller.animateTo(
      _controller.offset - 230, // Прокручиваемся на 100 пикселей назад
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  // Обработчик прокрутки колесиком мыши
  void handleScroll(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      _controller.animateTo(
        _controller.offset - event.scrollDelta.dy * 2,
        // Прокручиваемся на 100 пикселей назад
        duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Screen.isHeight(context, 200))
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
            child: Row(
              children: [
                Text(
                  'SheetBar',
                  style: CustomColors.getLabelLarge(context, null),
                ),
              ],
            ),
          ),
        if (Screen.isHeight(context, 200))
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: CustomColors.getPrimaryBackground(context),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  color: CustomColors.getSecondaryText(context),
                  onPressed: scrollBackward,
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Listener(
                    onPointerSignal: handleScroll,
                    child: ListView(
                      controller: _controller,
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      children: elements.map((e) {
                        return SheetElement(
                          label: e,
                          isSelected: e == selected,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                IconButton(
                  color: CustomColors.getSecondaryText(context),
                  onPressed: scrollForward,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        if (Screen.isHeight(context, 250))
          Padding(
            padding: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Divider(
                height: 12,
                thickness: 2,
                color: CustomColors.getAlternate(context),
              ),
            ),
          ),
        ContentList(),
      ],
    );
  }
}
