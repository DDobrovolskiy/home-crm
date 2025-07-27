import 'dart:ui'; // Для эффектов размытия

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_crm_front/theme/theme.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';

abstract class LoginPageBase<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _parallaxOffset;

  Form getForm(Store<AppState> store);

  @override
  void initState() {
    super.initState();

    // Настройка контроллера анимации
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
      reverseDuration: Duration(seconds: 10),
    );

    // Создание анимации смещения параллакса
    _parallaxOffset =
        Tween(begin: 0.0, end: 100.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.linear,
            reverseCurve: Curves.linear,
          ),
        )..addListener(() {
          if (_parallaxOffset.value >= 100.0) {
            _controller.reverse();
          }
          if (_parallaxOffset.value <= 0.0) {
            _controller.forward();
          }
        });

    // Запуск анимации
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        debugPrint('Build LoginMainPage at timestamp: ${DateTime.now()}');
        // Получаем размеры экрана
        final screenWidth = MediaQuery.of(context).size.width;
        // Определяем адаптивные размеры окна авторизации
        final windowWidth = screenWidth <= 600 ? screenWidth * 0.8 : 480.0;
        return SafeArea(
          child: AnimatedBuilder(
            animation: _parallaxOffset,
            builder: (context, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Transform.translate(
                      offset: Offset(
                        _parallaxOffset.value * 0.5,
                        _parallaxOffset.value * 0.2,
                      ),
                      child: Image.asset(
                        'assets/common/background3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Второй слой: Размытый фильтр и полупрозрачный черный оттенок
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.black.withOpacity(0.1)),
                  ),

                  // Третий слой: Центрированное диалоговое окно авторизации
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: windowWidth,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: const EdgeInsets.all(4.0),
                        elevation: 8.0,
                        color: Colors.white.withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/common/house.svg",
                                  height: 90,
                                  width: 90,
                                ),
                                // Заголовок окна
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'home',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: 'CRM',
                                        style: TextStyle(
                                          color: CustomColors.accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'система для вашего бизнеса',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                Divider(thickness: 1.0),
                                getForm(store),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
