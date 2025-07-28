import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/support/redux/state/app_state.dart';
import 'package:home_crm_front/domain/support/router/roters.dart';
import 'package:redux/redux.dart';

import '../../../theme/theme.dart';
import '../../support/phone.dart';
import 'login_base_page.dart';

class LoginRegistrationPage extends StatefulWidget {
  const LoginRegistrationPage({super.key});

  @override
  _LoginRegistrationPage createState() => _LoginRegistrationPage();
}

class _LoginRegistrationPage extends LoginPageBase<LoginRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _login;
  String? _password;

  @override
  Form getForm(Store<AppState> store) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              store.dispatch(NavigateToAction.replace(RoutersApp.login));
            },
            child: Text(
              '← У меня уже есть аккаунт',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'РЕГИСТРАЦИЯ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 10),
          _buildLoginField(),
          SizedBox(height: 5),
          _buildPasswordField(),
          SizedBox(height: 5),
          _buildSecondPasswordField(),
          const SizedBox(height: 10),

          // Ссылка на восстановление пароля
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
                print("true");
                print(_password);
                print(_login);
              } else {
                print("false");
              }
            },
            child: Text('Регистрация'),
          ),
        ],
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

  Widget _buildSecondPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Повторите пароль',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
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
