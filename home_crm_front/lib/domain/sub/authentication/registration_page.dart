import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/sub/authentication/event/auth_event.dart';
import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../../theme/theme.dart';
import '../../support/phone.dart';
import 'auth_base_page.dart';

@RoutePage()
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _LoginRegistrationPage createState() => _LoginRegistrationPage();
}

class _LoginRegistrationPage extends AuthPageBase<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _login;
  String? _password;
  bool _isHidden = true; // Переменная для управления отображением пароля

  @override
  Form getForm(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              AutoRouter.of(context).push(LoginRoute());
            },
            child: Text(
              '← У меня уже есть аккаунт',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'РЕГИСТРАЦИЯ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (state is AuthLoginErrorState) Column(
            children: [
              SizedBox(height: 5),
              Text(
                  state.message,
                  style: TextStyle(color: Colors.red)),
            ],
          ),
          SizedBox(height: 5),
          _buildNameField(),
          SizedBox(height: 5),
          _buildLoginField(),
          SizedBox(height: 5),
          _buildPasswordField(),
          SizedBox(height: 5),
          _buildMatchingPasswordField(),
          const SizedBox(height: 5),

          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(
                CustomColors.backgroundDark,
              ),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return CustomColors.accentColor.withOpacity(0.1);
                }
                return CustomColors.accentColor;
              }),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              minimumSize: WidgetStateProperty.all(Size(double.maxFinite, 56)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authBloc.add(AuthRegistrationEvent(
                    name: _name!, phone: _login!, password: _password!));
              }
            },
            child: state is AuthProcessingState
                ? CircularProgressIndicator()
                : const Text('Зарегистрироваться'),
          ),
        ],
      ),
    );
  }

  // Вспомогательные методы для построения полей ввода
  Widget _buildNameField() {
    return TextFormField(
      obscureText: false,
      decoration: const InputDecoration(
        labelText: 'Имя',
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
          return 'Поле имя обязательно для заполнения!';
        }
        return null;
      },
      onChanged: (value) => _name = value,
    );
  }

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
      obscureText: _isHidden,
      decoration: InputDecoration(
        labelText: 'Пароль',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
        suffixIcon: IconButton(
          icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            _isHidden = !_isHidden; // Переключаем состояние видимости
          },
        ),
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

  Widget _buildMatchingPasswordField() {
    return TextFormField(
      obscureText: _isHidden,
      decoration: InputDecoration(
        labelText: 'Повторите пароль',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
        suffixIcon: IconButton(
          icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            _isHidden = !_isHidden; // Переключаем состояние видимости
          },
        ),
      ),
      style: const TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != _password) {
          return 'Пароли не совпали!';
        }
        return null;
      },
    );
  }
}
