import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:ui'; // Для эффектов размытия
// import 'package:flutter/simulation.dart'; // Для симуляции физики
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_crm_front/domain/support/phone.dart';
import 'package:home_crm_front/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Для анимации

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _parallaxOffset;
  final _formKey = GlobalKey<FormState>();
  String? _login;
  String? _password;

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
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Divider(thickness: 1.0),
                            SizedBox(height: 5),
                            // Поле ввода логина
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildLoginField(),
                                  SizedBox(height: 5),
                                  _buildPasswordField(),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Забыли пароль?',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Кнопка входа
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: WidgetStateProperty.all(
                                  Size.fromWidth(420),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print("true");
                                  print(_password);
                                  print(_login);
                                } else {
                                  print("false");
                                }
                              },
                              child: const Text('Войти'),
                            ),
                            const SizedBox(height: 10),

                            // Ссылка на восстановление пароля
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                  CustomColors.backgroundDark,
                                ),
                                backgroundColor:
                                    WidgetStateProperty.resolveWith((states) {
                                      if (states.contains(
                                        WidgetState.pressed,
                                      )) {
                                        return CustomColors.accentColor
                                            .withOpacity(0.1);
                                      }
                                      return CustomColors.accentColor;
                                    }),
                                overlayColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                shadowColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all(
                                  Size(double.maxFinite, 56),
                                ),
                              ),
                              onPressed: () {},
                              child: Text('Регистрация'),
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
    return TextFormField(
      inputFormatters: [Phone.phoneFormatter],
      decoration: const InputDecoration(
        hintText: '+7 (___) ___-__-__',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      keyboardType: TextInputType.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (Phone.isValidPhoneNumber(value)) {
          return null;
        }
        return 'Поле телефона обязательно для заполнения!';
      },
      onChanged: (value) => _login = value,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Пароль',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      style: const TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Поле пароля обязательно для заполнения!';
        }
        return null;
      },
      onChanged: (value) => _password = value,
    );
  }
}
