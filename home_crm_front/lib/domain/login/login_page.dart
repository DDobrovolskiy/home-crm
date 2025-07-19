import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:ui'; // Для эффектов размытия
// import 'package:flutter/simulation.dart'; // Для симуляции физики
import 'package:flutter/animation.dart';
import 'package:flutter_svg/svg.dart'; // Для анимации

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _parallaxOffset;

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
    // final Simulation simulation = SpringSimulation(SpringDescription(mass: 1, stiffness: 100, damping: 1), 0.0, 100.0, 0.0);
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
                    'assets/common/background2.jpg',
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
                  width: 350,
                  height: 500,
                  // Фиксированная ширина окна
                  constraints: BoxConstraints(
                    maxWidth: 350,
                    minWidth: 350,
                    minHeight: 500,
                    maxHeight: 500,
                  ),
                  // Ограничение максимальной ширины
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.all(16.0),
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
                            const Text(
                              'Home CRM',
                              // style: TextStyle(
                              //   fontSize: 24,
                              //   fontWeight: FontWeight.bold,
                              //   color: Colors.black,
                              // ),
                            ),
                            const Text(
                              'система для вашего бизнеса',
                              style: TextStyle(fontSize: 12),
                            ),
                            const Divider(thickness: 1.0),
                            const SizedBox(height: 20),

                            // Поле ввода логина
                            _buildLoginField(),
                            const SizedBox(height: 15),

                            // Поле ввода пароля
                            _buildPasswordField(),

                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Забыли пароль?',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Кнопка входа
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: WidgetStateProperty.all(
                                  Size.fromWidth(420),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.blueAccent.shade700,
                                ),
                                // Заливка серым цветом
                                foregroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ), // Белый текст на кнопке
                              ),
                              onPressed: () {},
                              child: const Text('Войти'),
                            ),
                            const SizedBox(height: 10),

                            // Ссылка на восстановление пароля
                            TextButton(
                              style: ButtonStyle(
                                fixedSize: WidgetStateProperty.all(
                                  Size.fromWidth(420),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  Colors.grey.shade700,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Регистрация'),
                            ),
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
  }

  // Вспомогательные методы для построения полей ввода
  Widget _buildLoginField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Логин или Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Пароль',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
