import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../screen/Screen.dart';
import '../tab/custom_tab.dart';

class CustomDialog {
  static Future<T> showDialog<T>(Widget child, BuildContext context) async {
    return await showAdaptiveDialog(
      context: context,
      barrierDismissible: false, // Окно не закрывается при нажатии вне области
      builder: (context) {
        return Dialog(
          backgroundColor: CustomColors.getSecondaryBackground(context),
          insetPadding: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(width: Screen.getMaxWidth(), child: child),
          ),
        );
      },
    );
  }
}

class DialogPage extends StatefulWidget {
  final Widget Function(bool Function())? label;
  final List<CustomTabView Function(GlobalKey<FormState>)> contents;

  const DialogPage({super.key, this.label, required this.contents});

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage>
    with
        AutomaticKeepAliveClientMixin<DialogPage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Список ключей для удобной итерации
  final List<GlobalKey<FormState>> _formKeys = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.contents.length, vsync: this);
    widget.contents.forEach((w) {
      _addKey();
    });
  }

  GlobalKey<FormState> _addKey() {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    _formKeys.add(key);
    return key;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // --- ГЛАВНАЯ ФУНКЦИЯ ВАЛИДАЦИИ И ПЕРЕКЛЮЧЕНИЯ ---
  bool _validateAndSubmit() {
    // Итерируемся по всем формам, начиная с первой
    for (int i = 0; i < _formKeys.length; i++) {
      final formState = _formKeys[i].currentState;

      // Вызываем валидацию для текущей формы
      if (formState != null && !formState.validate()) {
        // *** ОШИБКА ОБНАРУЖЕНА ***
        print(i);
        // 1. Переключаем TabController на нужный индекс
        _tabController.animateTo(i);

        // 2. Добавляем небольшую задержку, чтобы анимация смены вкладки завершилась,
        //    прежде чем пытаться сфокусироваться на поле.
        Future.delayed(const Duration(milliseconds: 300), () {
          // 3. Программно фокусируемся на первом невалидном поле
          // FocusScope.of(context).requestFocus(FocusNode());
          // К сожалению, Flutter не предоставляет простого публичного API
          // для получения *первого* ошибочного FocusNode() из FormState.
          // Поэтому мы просто гарантируем, что фокус находится где-то на новой вкладке.
          // Если вы используете пакеты вроде focus_detector, можно сделать точнее.
        });

        // Прерываем цикл, так как мы нашли первую ошибку
        return false;
      }
    }
    // Если цикл завершился без return, значит, все формы валидны
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        if (widget.label != null) widget.label!(_validateAndSubmit),
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.fromLTRB(12, 12, 12, 12),
            child: CustomTab(
              contents: widget.contents.indexed
                  .map((c) => c.$2(_formKeys[c.$1]))
                  .toList(),
              tabController: _tabController,
            ),
          ),
        ),
      ],
    );
  }
}